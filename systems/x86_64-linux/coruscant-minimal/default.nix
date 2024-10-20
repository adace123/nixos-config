{ ... }:
{
  imports = [ ./disk.nix ];
  adace.suites = {
    system = {
      base.enable = true;
      security.enable = true;
    };
  };
}
