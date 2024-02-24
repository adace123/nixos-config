{
  description = "NixOS Config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-latest.url = "github:NixOS/nixpkgs";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wallpapers = {
      url = "github:adace123/wallpapers";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nuenv.url = "github:DeterminateSystems/nuenv";
    sops-nix.url = "github:Mic92/sops-nix";
    hyprkeys.url = "github:hyprland-community/Hyprkeys";
    hyprland-contrib.url = "github:hyprwm/contrib";
    pyprland.url = "github:hyprland-community/pyprland";
    nix-std.url = "github:chessai/nix-std";
    nix-colors.url = "github:misterio77/nix-colors";
    nur.url = "github:nix-community/NUR";
    pre-commit = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    grub-theme = {
      url = "github:shvchk/fallout-grub-theme";
      flake = false;
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nuenv,
    ...
  } @ inputs: let
    inherit (self) outputs;
    overlays = with inputs; [
      nuenv.overlays.nuenv
      nur.overlay
      outputs.overlays.default
      hyprland-contrib.overlays.default
    ];
    systems = ["x86_64-linux" "x86_64-darwin"];
    forEachSystem = nixpkgs.lib.genAttrs systems;
    forEachPkgs = f: forEachSystem (system: f (import nixpkgs {inherit system overlays;}));
  in {
    packages = forEachPkgs (pkgs: (import ./pkgs {inherit pkgs inputs;}));
    overlays = import ./overlays {inherit inputs;};
    devShells = forEachPkgs (pkgs: import ./shell.nix {inherit pkgs self;});
    checks = forEachPkgs (pkgs: {
      pre-commit-check = inputs.pre-commit.lib.${pkgs.system}.run {
        src = ./.;
        hooks = {
          alejandra.enable = true;
          deadnix.enable = true;
          nil.enable = true;
        };
      };
    });
    nixosConfigurations = import ./hosts {inherit overlays inputs outputs nixpkgs;};
  };
}
