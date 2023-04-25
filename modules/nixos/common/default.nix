{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./packages.nix
    ./nix.nix
    ./users.nix
    ./secrets
  ];
  time.timeZone = "America/Los_Angeles";

  networking = {
    useDHCP = false;
    firewall = {
      enable = true;
      allowPing = true;
    };
  };

  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "22.05";
}
