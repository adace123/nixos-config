{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nuenv.url = "github:DeterminateSystems/nuenv";
    sops-nix.url = "github:Mic92/sops-nix";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprkeys.url = "github:hyprland-community/Hyprkeys";
    nix-std.url = "github:chessai/nix-std";
    nix-colors.url = "github:misterio77/nix-colors";
    nur.url = "github:nix-community/NUR";
    amadeus-dotfiles-hyprland = {
      url = "github:AmadeusWM/dotfiles-hyprland?rev=6818be21d8b1d193168bda85017c277393e00589";
      flake = false;
    };
    astronvim = {
      url = "github:AstroNvim/AstroNvim";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    disko,
    nuenv,
    ...
  } @ inputs: let
    inherit (self) outputs;
    overlays = with inputs; [
      nuenv.overlays.nuenv
      nur.overlay
      outputs.overlays.default
    ];

    forEachSystem = nixpkgs.lib.genAttrs ["x86_64-linux" "x86_64-darwin"];
    forEachPkgs = f: forEachSystem (system: f (import nixpkgs {inherit system overlays;}));
  in {
    packages = forEachPkgs (pkgs: (import ./pkgs {inherit pkgs inputs;}));
    overlays = import ./overlays {inherit inputs;};
    devShells = forEachPkgs (pkgs: import ./shell.nix {inherit pkgs;});
    nixosConfigurations = import ./hosts {inherit inputs outputs nixpkgs;};
  };
}
