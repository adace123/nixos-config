{pkgs, ...}:
pkgs.buildGoModule rec {
  pname = "tgpt";
  version = "2.7.1";

  src = pkgs.fetchFromGitHub {
    owner = "aandrew-me";
    repo = "tgpt";
    rev = "refs/tags/v${version}";
    hash = pkgs.lib.fakeSha256;
  };

  vendorHash = "sha256-HXpSoihk0s218DVCHe9VCGLBggWY8I25sw2qSaiUz4I=";

  ldflags = [
    "-s"
    "-w"
  ];
}
