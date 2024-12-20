{
  programs.nixvim = {
    plugins.obsidian = {
      enable = true;
      settings = {
        workspaces = [
          {
            name = "personal";
            path = "~/Notes/personal";
          }
          {
            name = "work";
            path = "~/Notes/work";
          }
        ];
      };
    };
    keymaps = [
      {
        key = "<leader>on";
        action = ":ObsidianNew<CR>";
        options.desc = "New note";
      }
      {
        key = "<leader>ot";
        action = ":ObsidianToggleCheckbox<CR>";
        options.desc = "Toggle checkbox";
      }
      {
        key = "<leader>oj";
        action = ":ObsidianToday<CR>";
        options.desc = "Today's journal";
      }
      {
        key = "<leader>of";
        action = ":ObsidianFollowLink<CR>";
        options.desc = "Follow note link";
      }
      {
        key = "<leader>oT";
        action = ":ObsidianTags<CR>";
        options.desc = "Note tags";
      }
      {
        key = "<leader>os";
        action = ":ObsidianSearch<CR>";
        options.desc = "Search notes";
      }
      {
        key = "<leader>ol";
        action = ":ObsidianLinks<CR>";
        options.desc = "Links";
      }
      {
        key = "<leader>ow";
        action = ":ObsidianWorkspace<CR>";
        options.desc = "Workspace";
      }
    ];
  };
}
