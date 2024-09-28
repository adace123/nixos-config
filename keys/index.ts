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
  url?: string;
  sops?: HostSopsConfig;
  sshUrl?: string;
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
  const privateKeyPath = path.join(sshConfigPath, hostConfig.name);
  sshKeyPair.privateKeyOpenssh.apply((key: string) =>
    fs.writeFileSync(privateKeyPath, key),
  );
  sshKeyPair.publicKeyOpenssh.apply((key: string) =>
    fs.writeFileSync(`../hosts/${hostConfig.name}/${hostConfig.name}.pub`, key),
  );

  return {
    privKey: sshKeyPair.privateKeyOpenssh,
    pubKey: sshKeyPair.publicKeyOpenssh,
  };
}

function updateSopsConfig(agePubKey: pulumi.Output<string>) {
  agePubKey.apply((key: string) => {
    const sopsConfigYAML = parse(fs.readFileSync("../.sops.yaml").toString());

    sopsConfigYAML.keys = [key];

    for (const rule of sopsConfigYAML.creation_rules) {
      rule.key_groups = [{ age: [key] }];
    }

    fs.writeFileSync("../.sops.yaml", stringify(sopsConfigYAML));
  });
}

function generateAgeKeyPair(): SopsAgeKeys {
  const sopsSSHKey = new tls.PrivateKey("sops-key", {
    algorithm: "ED25519",
  });

  const agePrivKey = sopsSSHKey.privateKeyOpenssh.apply((key: string) => {
    return new local.Command("ssh-to-age", {
      create: `echo "${key}" | ssh-to-age -private-key`,
    }).stdout;
  });

  const agePubKey = new local.Command("age-public-key", {
    create: pulumi.interpolate`echo ${agePrivKey} | age-keygen -y`,
  }).stdout;

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

const config = new pulumi.Config();
const hostConfigs =
  config.requireObject<Array<HostSecretConfig>>("host-configs");

const { sops, age } = generateAgeKeyPair();
updateSopsConfig(age.pubKey);

const keys = new Map<string, object>([
  ["age", { privKey: age.privKey, pubKey: age.pubKey }],
  ["sops", { privKey: sops.privKey, pubKey: sops.pubKey }],
]);

// make sure secrets are encrypted with new private key, not old one
pulumi
  .all([age.privKey, age.pubKey])
  .apply(([privKey, _pubKey]: Array<string>) => {
    for (const hostConfig of hostConfigs) {
      if (hostConfig.sops?.rawPath !== undefined) {
        new local.Command(`encrypt-sops-${hostConfig.name}`, {
          create: `sops -e ${hostConfig.sops?.rawPath} > ${hostConfig.sops?.encryptedPath}`,
          update: `sops -e ${hostConfig.sops?.rawPath} > ${hostConfig.sops?.encryptedPath}`,
          environment: {
            SOPS_AGE_KEY: privKey,
          },
          dir: "..",
        });
      }
    }
  });

for (const hostConfig of hostConfigs) {
  if (hostConfig.sshUrl !== undefined) {
    const sshKeyPair = generateSshKeyPair(hostConfig);
    keys.set(hostConfig.name, {
      privKey: pulumi.secret(sshKeyPair.privKey),
      pubKey: sshKeyPair.pubKey,
      url: pulumi.output(hostConfig.sshUrl),
    });
  }
}

module.exports = Object.fromEntries(keys);
