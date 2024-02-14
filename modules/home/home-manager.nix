{
  config,
  inputs,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${config.modules.user.name} = {
      home.stateVersion = config.system.stateVersion;
      imports = with inputs; [
        ./.
        ../../modules/home/desktop/editors/neovim
        ../../hosts/${config.networking.hostName}/home.nix
        nix-colors.homeManagerModules.default
        nixvim.homeManagerModules.nixvim
      ];
    };
  };
}
