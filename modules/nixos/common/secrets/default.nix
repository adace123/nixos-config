{
  config,
  lib,
  pkgs,
  ...
}:
# inherit (inputs) agenix;
# hostSecretsDir = "${builtins.toString ../../../../hosts}/${config.networking.hostName}";
# readSecretsDir = dir:
#   if builtins.pathExists "${dir}/secrets.nix"
#   then
#     mapAttrs' (n: _:
#       nameValuePair (removeSuffix ".age" n) {
#         file = "${dir}/${n}";
#         owner = mkDefault config.user.name;
#       }) (import "${dir}/secrets.nix")
#   else {};
{
  # age = {
  #   secrets = (readSecretsDir (builtins.toString ./.)) // (readSecretsDir hostSecretsDir);
  #   identityPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  # };
  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    gnupg.sshKeyPaths = [];
  };
}
