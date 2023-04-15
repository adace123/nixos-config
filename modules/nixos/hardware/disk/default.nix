{
  inputs,
  config,
  lib,
  pkgs,
  options,
  ...
}:
with lib; let
  inherit (config.modules.hardware) device enableConfig;
  deviceName = builtins.baseNameOf device;
in {
  imports = [
    inputs.disko.nixosModules.disko
    ./script.nix
  ];

  options.modules.hardware.device = mkOption {
    description = "Drive to install NixOS on";
    type = types.str;
  };

  options.modules.hardware.enableConfig = mkOption {
    type = types.bool;
    default = true;
    description = "Enable Disko config";
  };

  config = {
    disko.enableConfig = builtins.getEnv "NIXOS_INSTALL_MODE" != "1";
    disko.devices.disk.${deviceName} = {
      inherit device;
      type = "disk";
      content = {
        type = "table";
        format = "gpt";
        partitions = [
          {
            name = "esp";
            type = "partition";
            start = "1MiB";
            end = "128MiB";
            fs-type = "fat32";
            bootable = true;
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          }
          {
            name = "primary";
            type = "partition";
            start = "128MiB";
            end = "-1G";
            content = {
              type = "luks";
              name = "crypted-root";
              keyFile = "/tmp/cryptroot.key";
              content = {
                type = "btrfs";
                mountpoint = "/";
                mountOptions = ["noatime"];
                extraArgs = ["-L" "nixos"];
                subvolumes = {
                  "/home" = {
                    mountOptions = ["compress=zstd"];
                    mountpoint = "/home";
                  };
                  "/nix" = {
                    mountOptions = ["compress=zstd" "noatime"];
                    mountpoint = "/nix";
                  };
                };
              };
            };
          }
          {
            name = "swap";
            type = "partition";
            start = "-1G";
            end = "100%";
            part-type = "primary";
            content = {
              type = "swap";
              randomEncryption = true;
            };
          }
        ];
      };
    };
  };
}
