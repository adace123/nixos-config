return {
	{ "sam4llis/nvim-tundra" },
	{ "LunarVim/horizon.nvim" },
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require("hlslens").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		config = function()
			local colors = require("tokyonight.colors").setup()
			require("scrollbar").setup({
				handle = {
					color = "#8338ec",
				},
			})
		end,
	},
	{ "hrsh7th/cmp-cmdline" },
  {
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
	},
  { "rcarriga/nvim-notify" },
}
