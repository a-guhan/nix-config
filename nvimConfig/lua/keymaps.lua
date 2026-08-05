local map = vim.keymap.set
local fn = vim.fn
local fzf = require("fzf-lua")

local opts = { silent = true }

map(
	"n",
	"<leader>e",
	"<cmd>Neotree toggle<CR>",
	vim.tbl_extend("force", opts, {
		desc = "Explorer",
	})
)

map(
	"n",
	"<leader>ff",
	fzf.files,
	vim.tbl_extend("force", opts, {
		desc = "Find Files",
	})
)

map(
	"n",
	"<leader>fg",
	fzf.live_grep,
	vim.tbl_extend("force", opts, {
		desc = "Live Grep",
	})
)

map("n", "<leader>fp", function()
	vim.notify(fn.expand("%:p"))
end, {
	desc = "Show File Path",
})

map("n", "<leader>cp", function()
	fn.setreg("+", fn.expand("%:p"))
	vim.notify("Copied file path")
end, {
	desc = "Copy File Path",
})

map("v", "y", '"+y', { desc = "Yank the selected text" })
map("n", "<leader>a", "ggVG", { noremap = true, silent = true, desc = "Select all" })
