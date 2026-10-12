return {
	"adriancmiranda/glimpse.nvim",
	opts = {},
	keys = {
		{
			"<leader>vp",
			function()
				local path = vim.api.nvim_buf_get_name(0)
				local glimpse = require("glimpse")

				if not glimpse.is_video(path) then
					vim.notify("Current file is not a supported video", vim.log.levels.WARN)
					return
				end

				glimpse.preview(path)
			end,
			desc = "Preview video",
		},
	},
}
