return {
	"ibhagwan/fzf-lua",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	opts = function()
		local actions = require("fzf-lua.actions")

		return {
			actions = {
				files = {
					true,
					["enter"] = actions.file_edit_or_qf,
					["ctrl-s"] = actions.file_split,
					["ctrl-v"] = actions.file_vsplit,
				},
			},

			files = {
				hidden = false,
				previewer = false,
				cwd_prompt = false,
				git_icons = false,
			},

			grep = {
				hidden = false,
				previewer = false,
			},
		}
	end,
}
