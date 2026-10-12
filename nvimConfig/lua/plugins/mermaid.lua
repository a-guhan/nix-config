return {
	"kevalin/mermaid.nvim",
	ft = "mermaid",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("mermaid").setup({
			lint = { enabled = false },
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "mermaid",
			callback = function(args)
				vim.keymap.set("n", "<leader>mp", "<cmd>MermaidPreview<CR>", {
					buffer = args.buf,
					desc = "Preview Mermaid diagram",
				})
			end,
		})
	end,
}
