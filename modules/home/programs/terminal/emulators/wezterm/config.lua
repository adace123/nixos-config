-- if you *ARE* lazy-loading smart-splits.nvim (not recommended)
-- you have to use this instead, but note that this will not work
-- in all cases (e.g. over an SSH connection). Also note that
-- `pane:get_foreground_process_name()` can have high and highly variable
-- latency, so the other implementation of `is_vim()` will be more
-- performant as well.
local function is_vim(pane)
	-- This gsub is equivalent to POSIX basename(3)
	-- Given "/foo/bar" returns "bar"
	-- Given "c:\\foo\\bar" returns "bar"
	local process_name = string.gsub(pane:get_foreground_process_name(), "(.*[/\\])(.*)", "%2")
	return process_name == "nvim" or process_name == "vim"
end

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

local act = wezterm.action

return {
	font = wezterm.font("JetBrainsMono Nerd Font Mono"),
	font_size = 16,
	default_prog = { "/etc/profiles/per-user/aaron/bin/nu" },
	automatically_reload_config = true,
	window_close_confirmation = "NeverPrompt",
	color_scheme = "Catppuccin Macchiato",
	bold_brightens_ansi_colors = true,
	enable_wayland = true,
	hide_tab_bar_if_only_one_tab = true,
	front_end = "WebGpu",
	window_background_opacity = 0.94,
	keys = {
		-- move between split panes
		split_nav("move", "h"),
		split_nav("move", "j"),
		split_nav("move", "k"),
		split_nav("move", "l"),
		-- resize panes
		split_nav("resize", "h"),
		split_nav("resize", "j"),
		split_nav("resize", "k"),
		split_nav("resize", "l"),
		{
			key = "Enter",
			mods = "CTRL",
			action = act.SplitPane({
				direction = "Down",
			}),
		},
		{
			key = "Enter",
			mods = "CTRL|SHIFT",
			action = act.SplitPane({
				direction = "Right",
			}),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT",
			action = act.ClearScrollback("ScrollbackAndViewport"),
		},
		{
			key = "k",
			mods = "ALT|SHIFT",
			action = act.AdjustPaneSize({ "Up", 1 }),
		},
		{
			key = "l",
			mods = "ALT|SHIFT",
			action = act.AdjustPaneSize({ "Right", 1 }),
		},
		{
			key = "h",
			mods = "ALT|SHIFT",
			action = act.AdjustPaneSize({ "Left", 1 }),
		},

		{
			key = "j",
			mods = "ALT|SHIFT",
			action = act.AdjustPaneSize({ "Down", 1 }),
		},
		{
			key = "F",
			mods = "CTRL|SHIFT",
			action = act.Search({ CaseInSensitiveString = "" }),
		},
		{
			key = "w", -- The key you want to use
			mods = "CTRL|SHIFT", -- Modifier keys
			action = act.CloseCurrentPane({ confirm = false }), -- Close without confirmation
		},
		{
			key = "j",
			mods = "CTRL|SHIFT",
			action = act.ScrollByPage(1),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT",
			action = act.ScrollByPage(-1),
		},
		{
			key = "g",
			mods = "CTRL|SHIFT",
			action = act.ScrollToTop,
		},
		{
			key = "e",
			mods = "CTRL|SHIFT",
			action = act.ScrollToBottom,
		},
		{
			key = "p",
			mods = "CTRL|SHIFT|SUPER",
			action = act.PaneSelect,
		},
		{
			key = "t",
			mods = "CTRL|SHIFT",
			action = act.ShowTabNavigator,
		},
		{
			key = "p",
			mods = "ALT|SHIFT",
			action = act.ActivateCommandPalette,
		},
	},
}
