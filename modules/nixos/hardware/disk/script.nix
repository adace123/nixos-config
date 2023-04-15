{
  config,
  lib,
  pkgs,
  ...
}: {
  system.build.install = pkgs.writeShellApplication {
    name = "system-install";
    text = ''
      # run disko script
      export NIXOS_INSTALL_MODE=1
      ${config.system.build.disko}
      # install
      # nixos-install --root /mnt --system ${config.system.build.toplevel} \
      #   --option extra-substituters "https://cache.nichi.co" \
      #   --option trusted-public-keys "hydra.nichi.co-0:P3nkYHhmcLR3eNJgOAnHDjmQLkfqheGyhZ6GLrUVHwk="
    '';
  };
}
