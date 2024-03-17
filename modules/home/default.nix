{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./desktop
    ./shell
    ./dev
    ./programs
  ];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = ["/etc/ssh/sops-nix"];
  };

  # restart sops-nix user service to pick up latest changes to secrets
  # Todo: Can something similar be implemented for darwin machines?
  home.activation = lib.mkIf pkgs.stdenv.isLinux {
    restartSops = config.lib.dag.entryAfter ["writeBoundary"] ''
      /run/current-system/sw/bin/systemctl start --user sops-nix
    '';
  };

  # default home packages
  home.packages = with pkgs; [
    home-manager
    nvd
    tgpt
    gopass
  ];
}
