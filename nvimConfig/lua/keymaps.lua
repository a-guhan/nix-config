local map = vim.keymap.set
local fn = vim.fn
local fzf = require("fzf-lua")
local buffers = require("utils.buffers")

local opts = { silent = true }

local function picker_with_opts(picker, picker_opts)
	return function()
		picker(picker_opts)
	end
end

local function project_grep(case_sensitive, hidden)
	local case_flag = case_sensitive and "--case-sensitive" or "--ignore-case"

	return function()
		-- fzf-lua escapes the entered query, so only case handling varies here.
		fzf.live_grep_native({
			hidden = hidden or false,
			rg_opts = table.concat({
				"--column",
				"--line-number",
				"--no-heading",
				"--color=always",
				"--max-columns=4096",
				case_flag,
				"-e",
			}, " "),
		})
	end
end

local function open_lazygit()
	if fn.executable("lazygit") ~= 1 then
		vim.notify("lazygit is not installed or not on PATH", vim.log.levels.ERROR)
		return
	end

	local current_dir = fn.expand("%:p:h")
	if current_dir == "" then
		current_dir = fn.getcwd()
	end

	local git_root = fn.systemlist({ "git", "-C", current_dir, "rev-parse", "--show-toplevel" })[1]
	if vim.v.shell_error ~= 0 or not git_root then
		vim.notify("Current file is not inside a Git repository", vim.log.levels.WARN)
		return
	end

	local Terminal = require("toggleterm.terminal").Terminal
	Terminal:new({
		cmd = fn.exepath("lazygit"),
		dir = git_root,
		direction = "float",
		hidden = true,
		close_on_exit = true,
	}):toggle()
end

local rg = vim.fn.exepath("rg")
local fast_file_command = string.format(
	"%s --files --color=never -g '!.git' -g '!.jj' -g '!**/.*'",
	vim.fn.shellescape(rg ~= "" and rg or "rg")
)

map(
	"n",
	"<leader>e",
	"<cmd>Neotree toggle<CR>",
	vim.tbl_extend("force", opts, {
		desc = "Explorer",
	})
)

map("n", "<leader>gg", open_lazygit, {
	desc = "Open LazyGit",
})

vim.api.nvim_create_user_command("LazyGit", open_lazygit, {
	desc = "Open LazyGit for the current Git repository",
})

map(
	"n",
	"<leader>ff",
	picker_with_opts(fzf.files, {
		-- One ripgrep scan works across a parent folder containing many repos.
		-- Keep ignore-file support, but never descend into hidden paths.
		cmd = fast_file_command,
	}),
	vim.tbl_extend("force", opts, {
		desc = "Find Files",
	})
)

map("n", "<leader>dff", picker_with_opts(fzf.files, { hidden = true }), {
	desc = "Find Files (including dotfiles)",
})

map(
	"n",
	"<leader>fg",
	project_grep(false),
	vim.tbl_extend("force", opts, {
		desc = "Live Grep (case-insensitive)",
	})
)

map(
	"n",
	"<leader>fG",
	project_grep(true),
	vim.tbl_extend("force", opts, {
		desc = "Live Grep (case-sensitive)",
	})
)

map("n", "<leader>dfg", project_grep(false, true), {
	desc = "Live Grep (case-insensitive, including dotfiles)",
})

map("n", "<leader>dfG", project_grep(true, true), {
	desc = "Live Grep (case-sensitive, including dotfiles)",
})

map(
	"n",
	"<leader>fw",
	fzf.grep_cword,
	vim.tbl_extend("force", opts, {
		desc = "Find Word",
	})
)

map("n", "<leader>dfw", picker_with_opts(fzf.grep_cword, { hidden = true }), {
	desc = "Find Word (including dotfiles)",
})

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

map("n", "<leader>bh", "<cmd>split<CR>", vim.tbl_extend("force", opts, { desc = "Horizontal Split" }))
map("n", "<leader>bv", "<cmd>vsplit<CR>", vim.tbl_extend("force", opts, { desc = "Vertical Split" }))
map("n", "<leader>bd", buffers.delete, vim.tbl_extend("force", opts, { desc = "Delete Buffer" }))
map("n", "<leader>bl", function()
	vim.cmd("Lazy load bufferline.nvim")
	vim.o.showtabline = vim.o.showtabline == 0 and 2 or 0
end, vim.tbl_extend("force", opts, { desc = "Toggle Buffer Line" }))

map("n", "<Tab>", "<cmd>bnext<CR>", vim.tbl_extend("force", opts, { desc = "Next Buffer" }))
map("n", "<S-Tab>", "<cmd>bprevious<CR>", vim.tbl_extend("force", opts, { desc = "Previous Buffer" }))

map("i", "jk", "<Esc>", { desc = "Exit Insert Mode" })

vim.api.nvim_create_user_command("CT", function()
	local theme = vim.g.colors_name == "vague" and "vague" or "catppuccin"
	vim.cmd.colorscheme(theme)
	vim.notify("Colorscheme: " .. theme)
end, {
	desc = "Toggle between Catppuccin and Vague",
})
