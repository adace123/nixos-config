_: {
  programs.nixvim.plugins = {
    ollama = {
      enable = true;
      model = "phi3";
    };
    which-key.registrations = {
      "<leader>a" = "AI+";
      "<leader>ae" = ":Ollama Explain_Code<CR>";
      "<leader>ag" = ":Ollama Generate_Code<CR>";
      "<leader>ac" = ":Ollama Raw<CR>";
    };
  };
}
