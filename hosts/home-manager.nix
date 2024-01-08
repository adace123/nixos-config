{
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
        ../modules/home
        ./${config.networking.hostName}/home.nix
        nix-colors.homeManagerModules.default
        nixvim.homeManagerModules.nixvim
      ];
    };
  };
}
