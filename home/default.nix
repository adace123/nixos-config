{
  inputs,
  nixpkgs,
  config,
  system ? "x86_64-linux",
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${config.user.name} = {
      home.stateVersion = config.system.stateVersion;
      # imports = [../../modules/home ../${config.networking.hostName}/home.nix];
    };
  };
}
