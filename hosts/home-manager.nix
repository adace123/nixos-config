{
  inputs,
  config,
  ...
}: {
  home-manager = {
    backupFileExtension = "bak";
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${config.modules.user.name} = {
      home.stateVersion = config.system.stateVersion;
      imports = with inputs; [
        ../modules/home
        ./${config.networking.hostName}/home.nix
        nixvim.homeManagerModules.nixvim
        inputs.sops-nix.homeManagerModules.sops
      ];
    };
  };
}
