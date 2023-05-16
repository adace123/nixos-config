{
  inputs,
  config,
  lib,
  pkgs,
  options,
  ...
}:
with lib; let
  inherit (config.sys.boot) device;
  deviceName = builtins.baseNameOf device;
in {
  imports = [
    inputs.disko.nixosModules.disko
  ];

  options.sys.boot.device = mkOption {
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
            start = "128MiB";
            end = "-1G";
            content = {
              type = "luks";
              name = "cryptroot";
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
        ];
      };
    };
  };
}
