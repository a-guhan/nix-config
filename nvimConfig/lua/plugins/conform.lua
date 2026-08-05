return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			nix = { "nixfmt" },
		},
		format_on_save = {
			timeout_ms = 3000,
			lsp_format = "never",
		},
	},
}
