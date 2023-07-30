{config, ...}:
with config.colorScheme.colors; {
  webpage = {
    darkmode = {
      enabled = true;
    };
    preferred_color_scheme = "dark";
    bg = "#${base00}";
  };

  completion = {
    fg = "#${base05}";
    match.fg = "#${base09}";
    even.bg = "#${base00}";
    odd.bg = "#${base00}";
    scrollbar = {
      bg = "#${base00}";
      fg = "#${base05}";
    };
    category = {
      bg = "#${base00}";
      fg = "#${base0D}";
      border = {
        bottom = "#${base00}";
        top = "#${base00}";
      };
    };
    item.selected = {
      bg = "#${base02}";
      fg = "#${base05}";
      match.fg = "#${base05}";
      border = {
        bottom = "#${base02}";
        top = "#${base02}";
      };
    };
  };

  contextmenu = {
    disabled = {
      bg = "#${base01}";
      fg = "#${base04}";
    };
    menu = {
      bg = "#${base00}";
      fg = "#${base05}";
    };
    selected = {
      bg = "#${base02}";
      fg = "#${base05}";
    };
  };
  downloads = {
    bar.bg = "#${base00}";
    error.fg = "#${base08}";
    start = {
      bg = "#${base0D}";
      fg = "#${base00}";
    };
    stop = {
      bg = "#${base0C}";
      fg = "#${base00}";
    };
  };
  hints = {
    bg = "#${base0A}";
    fg = "#${base00}";
    match.fg = "#${base05}";
  };
  keyhint = {
    bg = "#${base00}";
    fg = "#${base05}";
    suffix.fg = "#${base05}";
  };
  messages = {
    error.bg = "#${base08}";
    error.border = "#${base08}";
    error.fg = "#${base00}";
    info.bg = "#${base00}";
    info.border = "#${base00}";
    info.fg = "#${base05}";
    warning.bg = "#${base0E}";
    warning.border = "#${base0E}";
    warning.fg = "#${base00}";
  };
  prompts = {
    bg = "#${base00}";
    fg = "#${base05}";
    border = "#${base00}";
    selected.bg = "#${base02}";
  };
  statusbar = {
    caret.bg = "#${base00}";
    caret.fg = "#${base0D}";
    caret.selection.bg = "#${base00}";
    caret.selection.fg = "#${base0D}";
    command.bg = "#${base01}";
    command.fg = "#${base04}";
    command.private.bg = "#${base01}";
    command.private.fg = "#${base0E}";
    insert.bg = "#${base00}";
    insert.fg = "#${base0C}";
    normal.bg = "#${base00}";
    normal.fg = "#${base05}";
    passthrough.bg = "#${base00}";
    passthrough.fg = "#${base0A}";
    private.bg = "#${base00}";
    private.fg = "#${base0E}";
    progress.bg = "#${base0D}";
    url.error.fg = "#${base08}";
    url.fg = "#${base05}";
    url.hover.fg = "#${base09}";
    url.success.http.fg = "#${base0B}";
    url.success.https.fg = "#${base0B}";
    url.warn.fg = "#${base0E}";
  };
  tabs = {
    bar.bg = "#${base00}";
    even.bg = "#${base00}";
    even.fg = "#${base05}";
    indicator.error = "#${base08}";
    indicator.start = "#${base0D}";
    indicator.stop = "#${base0C}";
    odd.bg = "#${base00}";
    odd.fg = "#${base05}";
    pinned.even.bg = "#${base0B}";
    pinned.even.fg = "#${base00}";
    pinned.odd.bg = "#${base0B}";
    pinned.odd.fg = "#${base00}";
    pinned.selected.even.bg = "#${base02}";
    pinned.selected.even.fg = "#${base05}";
    pinned.selected.odd.bg = "#${base02}";
    pinned.selected.odd.fg = "#${base05}";
    selected.even.bg = "#${base02}";
    selected.even.fg = "#${base05}";
    selected.odd.bg = "#${base02}";
    selected.odd.fg = "#${base05}";
  };
}
