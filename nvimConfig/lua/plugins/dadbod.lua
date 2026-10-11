local connections = require("utils.db_connections")
connections.setup()

local dbs = connections.urls()

-- Environment variables are a convenient fallback that keeps credentials out
-- of the Neovim config and shell history.
dbs["local-postgres"] = dbs["local-postgres"] or vim.env.NVIM_POSTGRES_URL
dbs["local-mysql"] = dbs["local-mysql"] or vim.env.NVIM_MYSQL_URL

for name, url in pairs(dbs) do
	if not url or url == "" then
		dbs[name] = nil
	end
end

vim.g.dbs = dbs

return {
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{
				"kristijanhusak/vim-dadbod-completion",
				ft = { "sql", "mysql", "plsql" },
			},
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_winwidth = 36
			vim.g.db_ui_dbout_list_sort = "desc"
			vim.g.db_ui_auto_execute_table_helpers = 1
			vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		ft = { "sql", "mysql", "plsql" },
		dependencies = {
			"hrsh7th/cmp-buffer",
			"kristijanhusak/vim-dadbod-completion",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
				}),
			})
			cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
				sources = {
					{ name = "vim_dadbod_completion" },
					{ name = "buffer" },
				},
			})
		end,
	},
}
