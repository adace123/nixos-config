{ ... }:
{
  imports = [ ./disk.nix ];
  adace.system.user.sudo.enable = true;
  adace.suites = {
    system = {
      base.enable = true;
      security.enable = true;
    };
  };
}
