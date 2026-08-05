local parsers = {
	"lua",
	"vim",
	"vimdoc",

	"typescript",
	"tsx",
	"javascript",
	"haskell",
	"nix",

	"json",
	"yaml",
	"toml",

	"markdown",
	"markdown_inline",

	"bash",
	"dockerfile",
	"gitignore",
}

return {
	"nvim-treesitter/nvim-treesitter",

	-- The current nvim-treesitter rewrite does not support lazy-loading.
	lazy = false,
	build = ":TSUpdate",

	config = function()
		local treesitter = require("nvim-treesitter")

		local function enable(buf)
			if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_buf_is_loaded(buf) then
				return
			end

			-- start() fails when the buffer's filetype has no installed parser.
			if pcall(vim.treesitter.start, buf) then
				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end

		local group = vim.api.nvim_create_augroup("treesitter-enable", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			callback = function(args)
				enable(args.buf)
			end,
		})

		-- install() is asynchronous and is a no-op for parsers already present.
		-- Once a first-time install finishes, enable Treesitter in open buffers too.
		treesitter.install(parsers):await(function(err, installed)
			vim.schedule(function()
				if err or not installed then
					vim.notify("Some Treesitter parsers could not be installed; run :TSLog", vim.log.levels.WARN)
				end

				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
					enable(buf)
				end
			end)
		end)

		treesitter.setup({
			indent = { enable = true },
		})
	end,
}
