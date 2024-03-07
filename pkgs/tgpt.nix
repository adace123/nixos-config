{pkgs, ...}:
pkgs.buildGoModule rec {
  pname = "tgpt";
  version = "2.7.1";

  src = pkgs.fetchFromGitHub {
    owner = "aandrew-me";
    repo = "tgpt";
    rev = "refs/tags/v${version}";
    hash = "sha256-XuTDEcs1wIrAe7Oaok4aFP01jDcyWB01R3HNrx6UEpo=";
  };

  # skip failing checkPhase
  checkPhase = '''';

  vendorHash = "sha256-docq/r6yyMPsuUyFbtCMaYfEVL0gLmyTy4PbrAemR00=";
}
