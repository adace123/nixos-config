_: {
  programs.nixvim.plugins = {
    ollama = {
      enable = true;
      model = "codegemma:2b";
    };
  };
}
