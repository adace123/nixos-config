{
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation {
  name = "firefox-vertical-tabs";
  src = fetchFromGitHub {
    owner = "ranmaru22";
    repo = "firefox-vertical-tabs";
    rev = "91501db";
    sha256 = "D4ZZPm/li1Eoo1TmDS/lI2MAlgosNGOOk4qODqIaCes=";
    meta = {};
  };
}
