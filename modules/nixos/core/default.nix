_: {
  imports = [
    ./nix.nix
    ./users.nix
    ./fonts.nix
    ./packages.nix
  ];

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "22.05";

  networking = {
    useDHCP = false;
    firewall = {
      enable = true;
      allowPing = true;
    };
  };
}
