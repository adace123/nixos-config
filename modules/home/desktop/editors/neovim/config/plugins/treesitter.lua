return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"lua",
				"vim",
				"markdown",
				"markdown_inline",
				"bash",
				"python",
				"terraform",
				"go",
				"rust",
				"typescript",
				"javascript",
				"yaml",
				"json",
				"zig",
				"markdown",
				"mermaid",
				"nix",
				"proto",
				-- "ruby",
				"sql",
				"elixir",
			}, -- put the language you want in this array
			-- ensure_installed = "all", -- one of "all" or a list of languages
			ignore_install = { "" }, -- List of parsers to ignore installing
			sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

			highlight = {
				enable = true, -- false will disable the whole extension
				disable = { "css" }, -- list of language that will be disabled
			},
			autopairs = {
				enable = true,
			},
			indent = { enable = true, disable = { "python", "css" } },

			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					scope_incremental = "<S-CR>",
					node_decremental = "<BS>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
						-- You can optionally set descriptions to the mappings (used in the desc parameter of
						-- nvim_buf_set_keymap) which plugins like which-key display
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
					},
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						["@class.outer"] = "<c-v>", -- blockwise
					},
					include_surrounding_whitespace = true,
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = { query = "@class.outer", desc = "Next class start" },
						["]b"] = "@block.outer",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
						["]B"] = "@block.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[b"] = "@block.outer",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
						["[B"] = "@block.outer",
					},
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
