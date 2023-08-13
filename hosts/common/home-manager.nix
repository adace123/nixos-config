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
      imports = with inputs; [
        ../../modules/home
        ../${config.networking.hostName}/home.nix
        hyprland.homeManagerModules.default
        nix-colors.homeManagerModules.default
      ];
    };
  };
}
