return {
	"jose-elias-alvarez/null-ls.nvim",
	opts = function(_, opts)
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics
		local code_actions = null_ls.builtins.code_actions

		opts.sources = {
			--formatting
			formatting.prettier.with({
				extra_filetypes = { "toml" },
				extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
			}),
			formatting.stylua,
			formatting.ruff,
			formatting.black.with({ extra_args = { "--fast" } }),
      formatting.isort,
			formatting.rustfmt,
			formatting.alejandra,
			formatting.yamlfmt,
			formatting.zigfmt,
			formatting.gofmt,
			formatting.fixjson,
			formatting.goimports,
			formatting.taplo,
			formatting.terraform_fmt,

			-- diagnostics
			diagnostics.ruff.with({
				diagnostics_postprocess = function(diagnostic)
					diagnostic.severity = vim.diagnostic.severity["WARN"]
				end,
			}),
			diagnostics.tsc,
			diagnostics.buf,
			diagnostics.jsonlint,
			diagnostics.shellcheck,
			diagnostics.statix,
			diagnostics.yamllint,

			-- code actions
			code_actions.statix,
			code_actions.eslint,
			code_actions.shellcheck,
		}
	end,
}
