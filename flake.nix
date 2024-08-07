{
  description = "NixOS Config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-latest.url = "github:NixOS/nixpkgs/master";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    wallpapers = {
      url = "github:adace123/wallpapers";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nuenv = {
      url = "github:DeterminateSystems/nuenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprkeys = {
      url = "github:hyprland-community/Hyprkeys";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pyprland = {
      url = "github:hyprland-community/pyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-std.url = "github:chessai/nix-std";
    nur.url = "github:nix-community/NUR";
    pre-commit = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nu_scripts = {
      url = "github:nushell/nu_scripts";
      flake = false;
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
    systems = ["x86_64-linux" "aarch64-darwin"];
    forEachSystem = nixpkgs.lib.genAttrs systems;
    forEachPkgs = f: forEachSystem (system: f (import nixpkgs {inherit system overlays;}));
  in
    {
      packages = forEachPkgs (pkgs: (import ./pkgs {inherit pkgs inputs;}));
      overlays = import ./overlays {inherit inputs;};
      devShells = forEachPkgs (pkgs: import ./shell.nix {inherit pkgs self;});
      checks = forEachPkgs (pkgs: {
        pre-commit-check = inputs.pre-commit.lib.${pkgs.system}.run {
          src = ./.;
          hooks = {
            alejandra.enable = true;
            commitizen.enable = true;
            deadnix.enable = true;
            nil.enable = true;
          };
        };
      });
    }
    // (import ./hosts {inherit inputs overlays;});
}
