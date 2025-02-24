{
  programs.nixvim = {
    plugins = {
      codecompanion = {
        enable = true;
        settings = {
          adapters = {
            ollama.__raw = ''
              function()
                return require('codecompanion.adapters').extend('ollama', {
                  env = {
                    url = "http://127.0.0.1:11434",
                  },
                  schema = {
                    model = {
                      default = "qwen2.5-coder:latest",
                    },
                  },
                })
              end
            '';
          };
          opts = {
            send_code = true;
            use_default_actions = true;
            use_default_prompts = true;
          };
          strategies = {
            agent = {
              adapter = "ollama";
            };
            chat = {
              adapter = "ollama";
            };
            inline = {
              adapter = "ollama";
            };
          };
        };
      };
    };
  };
}
