let
  currentHostname = builtins.head (builtins.match "([a-zA-Z0-9]+)\n" (builtins.readFile "/etc/hostname"));
  flake = builtins.getFlake (toString ./.);
in
  {hostname ? currentHostname}:
    flake // flake.nixosConfigurations.${hostname}
