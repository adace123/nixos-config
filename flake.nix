{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    disko,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    darwinPkgs = import nixpkgs {system = "x86_64-darwin";};
  in {
    devShells = {
      ${system}.default = pkgs.mkShell {
        packages = with pkgs; [just statix alejandra disko];
      };
      "x86_64-darwin".default = darwinPkgs.mkShell {
        packages = with darwinPkgs; [just statix alejandra ];
      };
    };

     nixosModules = {
      vm =
        { config, pkgs, lib, modulesPath, ... }:

        {
          imports = [
            "${modulesPath}/virtualisation/qemu-vm.nix"
          ];

          system.stateVersion = "22.05";

          # Configure networking
          networking.useDHCP = false;
          networking.interfaces.eth0.useDHCP = true;

          # Create user "test"
          services.getty.autologinUser = "test";
          users.users.test.isNormalUser = true;

          # Enable paswordless ‘sudo’ for the "test" user
          users.users.test.extraGroups = [ "wheel" ];
          security.sudo.wheelNeedsPassword = false;

          # Make it output to the terminal instead of separate window
          virtualisation.graphics = false;
        };
      withStoreImage = {
        virtualisation.useNixStoreImage = true;
        virtualisation.writableStore = true;
      };
    };

    nixosConfigurations = {
      hp-pavilion = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/hp-pavilion
          ./modules/nixos
        ];
        specialArgs = {inherit inputs;};
      };

      vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/vm
          ./modules/nixos
        ];
        specialArgs = {inherit inputs;};
      };
    };

    packages.x86_64-darwin.default = self.nixosConfigurations.vm-darwin.config.system.build.vm;
  };
}
