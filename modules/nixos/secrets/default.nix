{
  sops = {
    defaultSopsFile = ../../../hosts/common/secrets.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  };
}
