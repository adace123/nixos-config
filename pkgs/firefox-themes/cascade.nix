{
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation {
  name = "firefox-theme-cascade";
  src = fetchFromGitHub {
    owner = "andreasgrafen";
    repo = "cascade";
    rev = "a89173a";
    sha256 = "D4ZZPm/li1Eoo1TmDS/lI2MAlgosNGOOk4qODqIaCes=";
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
}
