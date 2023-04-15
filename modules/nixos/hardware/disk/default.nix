{
  inputs,
  config,
  lib,
  pkgs,
  options,
  ...
}:
with lib; let
  inherit (config.modules.hardware) device;
  deviceName = builtins.baseNameOf device;
in {
  imports = [
    inputs.disko.nixosModules.disko
  ];

  options.modules.hardware.device = mkOption {
    description = "Drive to install NixOS on";
    type = types.str;
  };

  config = {
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
