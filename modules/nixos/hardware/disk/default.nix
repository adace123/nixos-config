{
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  inherit (config.modules.boot) device;
  deviceName = builtins.baseNameOf device;
  cfg = config.modules.disko;
in {
  imports = [
    inputs.disko.nixosModules.disko
  ];

  options.modules.disko.enable = mkOption {
    description = "Enable disko partitioning";
    type = types.bool;
    default = true;
  };

  options.modules.boot.device = mkOption {
    description = "Drive to install NixOS on";
    type = types.str;
  };

  config = mkIf cfg.enable {
    disko.devices.disk.${deviceName} = {
      inherit device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            end = "1GiB";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              settings = {
                allowDiscards = true;
                keyFile = "/cryptroot.key";
              };
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  "root" = {
                    mountpoint = "/";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "home" = {
                    mountpoint = "/home";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["compress=zstd" "noatime" "noacl"];
                  };
                  "/swap" = {
                    mountpoint = "/.swapvol";
                    swap.swapfile.size = "20M";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
