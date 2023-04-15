{
  config,
  lib,
  pkgs,
  ...
}: {
  system.build = {
    generate-luks-key = pkgs.nuenv.mkScript {
      name = "generate-luks-key";
      script = ''
        def main [path = "/tmp/cryptroot.key"] {
          ${pkgs.openssl}/bin/openssl genrsa -out $path
          chmod -v 0400 $path
          chown root:root $path
          echo $"Saved LUKS key to ($path)"
        }
      '';
    };

    system-install = pkgs.writeShellApplication {
    name = "system-install";
    text = ''
      # run disko script
      ${config.system.build.disko}
      # install
      # nixos-install --root /mnt --system ${config.system.build.toplevel} \
      #   --option extra-substituters "https://cache.nichi.co" \
      #   --option trusted-public-keys "hydra.nichi.co-0:P3nkYHhmcLR3eNJgOAnHDjmQLkfqheGyhZ6GLrUVHwk="
    '';
  };
  };

}
