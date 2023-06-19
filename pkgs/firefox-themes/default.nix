{pkgs, ...}: {
  cascadeCatppuccin = pkgs.stdenv.mkDerivation {
    name = "cascade";
    src = pkgs.fetchgit {
      url = "https://github.com/andreasgrafen/cascade.git";
      rev = "a89173a";
      sha256 = "6czuf+lXjAhP3LlyT1tDDtlEf6tTuADgWwad6vaDW3s=";
    };

    # Replace files as described in:
    # https://github.com/andreasgrafen/cascade#catppuccin
    installPhase = ''
      mkdir -p $out

      cp ./integrations/catppuccin/*.css ./chrome/includes

      substituteInPlace ./chrome/userChrome.css  \
        --replace "colours" "mocha" \
        --replace "includes/cascade-colours" "$out/chrome/includes/"

      cp -r * $out
    '';
  };
}