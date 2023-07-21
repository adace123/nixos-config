{
  pkgs,
  inputs,
  config,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${config.user.name} = {
      home.stateVersion = config.system.stateVersion;
      sops = {
        defaultSopsFile = ../../secrets/${config.user.name}.yaml;
        age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      };
      imports = with inputs; [
        ../../modules/home
        ../${config.networking.hostName}/home.nix
        hyprland.homeManagerModules.default
        nix-colors.homeManagerModules.default
        sops-nix.homeManagerModules.sops
      ];
    };
  };
}
