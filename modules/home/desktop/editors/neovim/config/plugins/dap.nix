{
  programs.nixvim = {
    plugins.cmp-dap.enable = true;
    plugins.dap = {
      enable = true;
      extensions = {
        dap-ui.enable = true;
        dap-go.enable = true;
        dap-python.enable = true;
        dap-virtual-text.enable = true;
      };
    };
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>d";
        desc = "+debug";
      }
    ];
    keymaps = [
      {
        key = "<leader>db";
        action = ":DapToggleBreakpoint<CR>";
        options.desc = "Toggle breakpoint";
      }
      {
        key = "<leader>dc";
        action = ":DapContinue<CR>";
        options.desc = "Continue";
      }
      {
        key = "<leader>dt";
        action = ":DapTerminate<CR>";
        options.desc = "Terminate session";
      }
      {
        key = "<leader>ds";
        action = ":DapStepInto<CR>";
        options.desc = "Step into function call";
      }
      {
        key = "<leader>do";
        action = ":DapStepOut<CR>";
        options.desc = "Step out of function call";
      }
      {
        key = "<leader>dn";
        action = ":DapStepOver<CR>";
        options.desc = "Step over function call";
      }
      {
        key = "<leader>du";
        action = ":lua require('dapui').toggle()<CR>";
        options.desc = "Toggle UI";
      }
    ];
    extraConfigLua =
      # lua
      ''
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      '';
  };
}
