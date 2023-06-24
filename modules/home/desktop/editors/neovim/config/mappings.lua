return {
	i = {
		-- Escape
		["kj"] = "<ESC>",

		-- Editing
		["<C-z>"] = "<Esc>ui",
	},

	n = {
		-- lsp
		gd = "<cmd>lua vim.lsp.buf.definition()<cr>",

		-- Buffers
		["<S-l>"] = ":bnext<cr>",
		["<S-h>"] = ":bprevious<cr>",
		["<TAB>"] = ":bnext<cr>",
		["<S-TAB>"] = ":bprevious<cr>",
		["<S-x>"] = ":Bdelete!<cr>",

		-- Windows
		["<C-x>"] = "<C-w>q",

		-- Yank file
		["<C-y>"] = ":%y a<cr>",

		-- Redo
		["U"] = "<C-r>",

		-- which-key
		["<leader>"] = {
			L = { "<cmd>Lazy<cr>", "Lazy" },
			r = { "*:%s//", "Replace Under Cursor" },
			R = { "<cmd>Spectre<cr>", "Spectre" },
			T = { "<cmd>TroubleToggle<cr>", "Trouble Toggle" },

			-- git
			g = {
				r = { "<cmd>lua require('gitsigns').reset_hunk()<cr>", "Reset Hunk" },
				R = { "<cmd>lua require('gitsigns').reset_buffer()<cr>", "Reset Buffer" },
			},

			-- Telescope
			f = {
				j = { "<cmd>Telescope jumplist<cr>", "Jumplist" },
			},

			-- lsp
			l = {
				a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
				["]"] = { "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", "Next Diagnostic" },
				["["] = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Previous Diagnostic" },
				f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
				r = { "<cmd>Telescope lsp_references<cr>", "References" },
				R = { "<cmd>LspRestart<cr>", "Restart" },
				s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
				t = { "<cmd>TroubleToggle<cr>", "Trouble Toggle" },
				["@"] = { "<cmd>lua require('neogen').generate()<cr>", "Generate Annotation" },
			},

			-- split
			s = {
				h = { "<cmd>split %<cr>", "Horizontal" },
				v = { "<cmd>vsplit %<cr>", "Vertical" },
			},

			-- tabs
			["<tab>"] = {
				name = "Tab",
				["<tab>"] = { "<cmd>tabnew<cr>", "New Tab" },
				n = { "<cmd>tabnext<cr>", "Next Tab" },
				p = { "<cmd>tabprev<cr>", "Prev Tab" },
				x = { "<cmd>tabclose<cr>", "Close Tab" },
				c = { "<cmd>tabnew<cr>:e $MYVIMRC<CR>", "Open Config in New Tab" },
			},
		},

		-- Find word under cursor
		F = "<cmd>Telescope grep_string<cr>",
		-- Save without formatting
		W = "<cmd>:noautocmd w<cr>",
		-- Zen mode
		Z = "<cmd>ZenMode<cr>",
	},

	v = {
		J = ":m '>+1<cr>gv=gv",
		V = ":m '<-2<cr>gv=gv",

		-- make cursor stay at end of selection
		y = "ygv<esc>",

		-- search and replace
		r = "y:%s/<C-r>0/",
	},
}
