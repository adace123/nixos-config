return {
	{
		"LhKipp/nvim-nu",
		name = "nvim-nu",
		config = function()
			require("nvim-nu").setup({})
		end,
	},
  {
    "Saecki/crates.nvim",
    config = function ()
      require("crates").setup({
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        }
      })
    end
  },
  {
		"zbirenbaum/neodim",
		config = function()
			require("neodim").setup()
		end,
	},
  {
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup()
		end,
	},
  	{
		"onsails/lspkind.nvim",
	},
  	{ "ray-x/lsp_signature.nvim" },
{
		"danymat/neogen",
		config = function()
			require("neogen").setup()
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"simrat39/inlay-hints.nvim",
		config = function()
			require("inlay-hints").setup()
		end,
	},
  {
    "lvimuser/lsp-inlayhints.nvim",
    config = function ()
      require("lsp-inlayhints").setup()
    end
  },
  {
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup({})
		end,
	},
  {
		"kosayoda/nvim-lightbulb",
		config = function()
			require("nvim-lightbulb").setup({
				sign = {
					enabled = false,
				},
				virtual_text = {
					enabled = true,
				},
			})
		end,
	},
  {
		"RRethy/vim-illuminate",
	},
}
