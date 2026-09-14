return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "VeryLazy",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	init = function()
		vim.opt.showtabline = 0
	end,

	opts = function()
		local bufferline = require("bufferline")

		return {
			options = {
				mode = "buffers",
				style_preset = bufferline.style_preset.minimal,
				numbers = "none",
				diagnostics = "nvim_lsp",
				separator_style = "thin",
				indicator = {
					style = "underline",
				},
				buffer_close_icon = "x",
				modified_icon = "*",
				show_buffer_icons = true,
				show_buffer_close_icons = false,
				show_close_icon = false,
				show_duplicate_prefix = false,
				always_show_bufferline = true,
				auto_toggle_bufferline = false,
				enforce_regular_tabs = false,
				custom_filter = function(buf)
					return vim.api.nvim_buf_get_name(buf) ~= ""
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Explorer",
						text_align = "left",
						separator = true,
					},
				},
				close_command = function(buf)
					require("utils.buffers").delete(buf)
				end,
				right_mouse_command = function(buf)
					require("utils.buffers").delete(buf)
				end,
			},
		}
	end,
}
