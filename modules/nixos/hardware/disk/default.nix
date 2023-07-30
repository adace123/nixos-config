{
  inputs,
  config,
  lib,
  pkgs,
  options,
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
    # TODO:: Find another way to do this
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
            start = "1MiB";
            end = "1G";
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
            start = "1G";
            end = "-1G";
            content = {
              type = "luks";
              name = "cryptroot";
              keyFile = "/cryptroot.key";
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
        ];
      };
    };
  };
}
