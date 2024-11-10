_: _final: prev: {
  pulumi-bin = prev.pulumi-bin.overrideAttrs {
    version = "v3.188.0";
    src = prev.fetchFromGitHub {
      owner = "pulumi";
      repo = "pulumi";
      rev = "afac93f70cde7c89eb8c5820b490c917f540ef2e";
      hash = "sha256-LxR7lWaO35NCTePZ80GkbMyhEoeILcE+SRNDUAP4D5A=";
    };
  };
}
