{
  stdenv,
  fetchFromGitHub,
  inputs,
  pkgs,
  ...
}: let
  addonId = "{5b78178f-135d-4df2-821f-1f289be7f348}";
  inherit ((import inputs.nur).repos.rycee.firefox-addons) buildFirefoxXpiAddon;
in
  stdenv.mkDerivation {
    name = "catppuccin-mocha";

    meta = {};

    src = builtins.fetchurl {
      url = "https://github.com/catppuccin/firefox/releases/download/old/catppuccin_mocha_rosewater.xpi";
      sha256 = "1v8av2y7czh422khk1icb1r03djiw2kpdai81glsv5h14zv6a7w6";
    };

    preferLocalBuild = true;
    allowSubstitutes = true;

    buildCommand = ''
      dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
      mkdir -p "$dst"
      install -v -m644 "$src" "$dst/${addonId}.xpi"
    '';
  }
