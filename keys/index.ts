import * as pulumi from "@pulumi/pulumi";
import * as fs from "fs";
import * as path from "path";
import * as os from "os";
import * as tls from "@pulumi/tls";
import { local } from "@pulumi/command";
import { stringify, parse } from "yaml";

interface HostSopsConfig {
  encryptedPath: string;
  rawPath: string;
}

interface HostSecretConfig {
  name: string;
  sops?: HostSopsConfig;
  sshPubKeyPath?: string;
}

interface KeyPair {
  privKey: pulumi.Output<string>;
  pubKey: pulumi.Output<string>;
}

interface SopsAgeKeys {
  sops: KeyPair;
  age: KeyPair;
}

function generateSshKeyPair(hostConfig: HostSecretConfig): KeyPair {
  const sshKeyPair = new tls.PrivateKey(`${hostConfig.name}-ssh-key`, {
    algorithm: "ED25519",
  });

  const sshConfigPath = path.join(os.homedir(), ".ssh");
  const sshKeyPath = path.join(sshConfigPath, hostConfig.name);
  sshKeyPair.privateKeyOpenssh.apply((key) =>
    fs.writeFileSync(sshKeyPath, key),
  );
  sshKeyPair.publicKeyOpenssh.apply((key) =>
    fs.writeFileSync(`../hosts/${hostConfig.name}/${hostConfig.name}.pub`, key),
  );

  return {
    privKey: sshKeyPair.privateKeyOpenssh,
    pubKey: sshKeyPair.publicKeyOpenssh,
  };
}

function updateSopsConfig(agePubKey: pulumi.Output<string>) {
  agePubKey.apply((key) => {
    const sopsConfigYAML = parse(fs.readFileSync("../.sops.yaml").toString());

    sopsConfigYAML.keys = [key];

    sopsConfigYAML.creation_rules = [
      {
        path_regex: "hosts/*/secrets.yaml",
        key_groups: [{ age: [key] }],
      },
      {
        path_regex: "hosts/secrets.yaml",
        key_groups: [{ age: [key] }],
      },
    ];

    fs.writeFileSync("../.sops.yaml", stringify(sopsConfigYAML));
  });
}

function generateAgeKeyPair(): SopsAgeKeys {
  const sopsSSHKey = new tls.PrivateKey("sops-key", {
    algorithm: "ED25519",
  });

  const agePrivKey = sopsSSHKey.privateKeyOpenssh.apply((key) => {
    return new local.Command(
      "ssh-to-age",
      {
        create: `echo "${key}" | ssh-to-age -private-key`,
      },
      { dependsOn: [sopsSSHKey] },
    ).stdout;
  });

  const agePubKey = new local.Command("age-public-key", {
    create: pulumi.interpolate`echo ${agePrivKey} | age-keygen -y`,
  }).stdout;

  sopsSSHKey.privateKeyOpenssh.apply((key) => {
    const sshConfigPath = path.join(os.homedir(), ".ssh");
    fs.writeFileSync(path.join(sshConfigPath, "sops-nix"), key);
  });

  return {
    sops: {
      privKey: sopsSSHKey.privateKeyOpenssh,
      pubKey: sopsSSHKey.publicKeyOpenssh,
    },
    age: {
      privKey: agePrivKey,
      pubKey: agePubKey,
    },
  };
}

function encryptSecretsFile(
  hostConfig: HostSecretConfig,
  agePrivKey: pulumi.Output<string>,
) {
  if (
    hostConfig.sops?.rawPath !== undefined &&
    fs.existsSync(hostConfig.sops.rawPath)
  ) {
    new local.Command(`encrypt-${hostConfig.name}`, {
      create: pulumi.interpolate`sops -e ${hostConfig.sops?.rawPath} --output ${hostConfig.sops?.encryptedPath}`,
      update: pulumi.interpolate`sops -e ${hostConfig.sops?.rawPath} --output ${hostConfig.sops?.encryptedPath}`,
      environment: {
        SOPS_AGE_KEY: pulumi.interpolate`${agePrivKey}`,
      },
      dir: "..",
    });
  } else {
    pulumi.log.warn(`No sops secrets found for host ${hostConfig.name}`);
  }
}

const config = new pulumi.Config();
const hostConfigs =
  config.requireObject<Array<HostSecretConfig>>("host-configs");

const { sops, age } = generateAgeKeyPair();
updateSopsConfig(age.pubKey);

const keys = new Map<string, KeyPair>([
  ["age", { privKey: pulumi.secret(age.privKey), pubKey: age.pubKey }],
  ["sops", { privKey: pulumi.secret(sops.privKey), pubKey: sops.pubKey }],
]);

for (const hostConfig of hostConfigs) {
  encryptSecretsFile(hostConfig, age.privKey);

  if (hostConfig.sshPubKeyPath !== undefined) {
    const sshKeyPair = generateSshKeyPair(hostConfig);
    keys.set(hostConfig.name, {
      privKey: pulumi.secret(sshKeyPair.privKey),
      pubKey: sshKeyPair.pubKey,
    });
  }
}

module.exports = Object.fromEntries(keys);
