{
  config,
  inputs,
  host,
  pkgs,
  ...
}: {
  home-manager = with pkgs; {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${config.modules.user.name} = {
      home = {
        stateVersion = "21.11";
        username = config.modules.user.name;
        homeDirectory =
          if stdenv.isDarwin
          then "/Users/${config.modules.user.name}"
          else "/home/${config.modules.user.name}";
      };
      programs.home-manager.enable = true;
      imports = with inputs; [
        ./.
        ../../hosts/${host}/home.nix
        nix-colors.homeManagerModules.default
        nixvim.homeManagerModules.nixvim
        sops-nix.homeManagerModules.sops
        catppuccin.homeManagerModules.catppuccin
      ];
    };
  };
}
