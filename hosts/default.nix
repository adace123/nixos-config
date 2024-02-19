{
  inputs,
  overlays,
  ...
}: let
  myLib = import ../lib {inherit inputs overlays;};
  sharedModules = with inputs; [
    sops-nix.nixosModules.sops
    ../modules/nixos
  ];

  mkSystem = {
    host,
    system ? "x86_64-linux",
    fullBuild ? true,
  }: let
    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    homeModules =
      if (builtins.pathExists ./${host}/home.nix && fullBuild)
      then [
        inputs.home-manager.nixosModules.home-manager
        ../modules/home/home-manager.nix
        {
          home-manager.extraSpecialArgs = {
            inherit host inputs pkgs;
            std = inputs.nix-std.lib;
          };
        }
      ]
      else [];
  in
    pkgs.lib.nixosSystem {
      inherit system;
      modules =
        [
          ./${host}
          {
            networking.hostName = host;
          }
        ]
        ++ homeModules
        ++ sharedModules;
      specialArgs = {
        inherit host inputs system pkgs fullBuild;
        std = inputs.nix-std.lib;
      };
    };
in
  with myLib; {
    nixosConfigurations = {
      coruscant = mkSystem {host = "coruscant";};
      # The full system is too large to install via nixos-anywhere
      # Need to install a minimal version first
      coruscant-minimal = mkSystem {
        host = "coruscant";
        fullBuild = false;
      };
      iso = mkSystem {host = "iso";};
    };
    darwinConfigurations = {
      endor = mkDarwinSystem {
        # TODO: update to aarch64-darwin
        system = "x86_64-darwin";
        host = "endor";
      };
    };
  }
