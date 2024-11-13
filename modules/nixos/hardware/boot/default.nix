{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.adace.system.boot;
in
with lib;
{
  options.adace.system.boot = {
    enable = mkEnableOption "Boot options";
    silent = mkEnableOption "Silent boot";
    configLimit = mkOption {
      type = types.int;
      description = "NixOS generation limit";
      default = 5;
    };
  };
  config = mkIf cfg.enable {
    boot = {
      kernelPackages = pkgs.linuxKernel.packages.linux_6_11;
      kernelParams = optionals cfg.silent [
        # tell the kernel to not be verbose
        "quiet"

        # kernel log message level
        "loglevel=3" # 1: system is unusable | 3: error condition | 7: very verbose

        # udev log message level
        "udev.log_level=3"

        # lower the udev log level to show only errors or worse
        "rd.udev.log_level=3"

        # disable systemd status messages
        # rd prefix means systemd-udev will be used instead of initrd
        "systemd.show_status=auto"
        "rd.systemd.show_status=auto"

        # disable the cursor in vt to get a black screen during intermissions
        "vt.global_cursor_default=0"
      ];

      loader.efi.canTouchEfiVariables = true;
      loader.grub = {
        enable = true;
        efiSupport = true;
        enableCryptodisk = true;
        device = "nodev";
        useOSProber = true;
        configurationLimit = cfg.configLimit;
        catppuccin.enable = true;
      };

      # initrd = {
      #   systemd.enable = true;
      # };

      # TODO: enable lanzaboote
      # TODO: enable tailscale in initramfs
    };
  };
}
