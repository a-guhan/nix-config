return {
	"karb94/neoscroll.nvim",
	opts = {
		mappings = {},
		hide_cursor = false, -- Keep cursor visible during scroll
		stop_eof = true,
		respect_scrolloff = true, -- Honors your existing scrolloff = 8
		cursor_scrolls_alone = true,
		easing = "quadratic", -- Smooth deceleration feel
	},
	config = function(_, opts)
		local neoscroll = require("neoscroll")
		neoscroll.setup(opts)

		local keymap = {
			-- Fast mouse-style scrolling (half page)
			["<C-u>"] = function()
				neoscroll.ctrl_u({ duration = 200, easing = "circular" })
			end,
			["<C-d>"] = function()
				neoscroll.ctrl_d({ duration = 200, easing = "circular" })
			end,
			-- Full page scrolling
			["<C-b>"] = function()
				neoscroll.ctrl_b({ duration = 350, easing = "quintic" })
			end,
			["<C-f>"] = function()
				neoscroll.ctrl_f({ duration = 350, easing = "quintic" })
			end,
			-- Smooth recentering
			["zz"] = function()
				neoscroll.zz({ duration = 150, half_win = true })
			end,
			["zt"] = function()
				neoscroll.zt({ duration = 150, half_win = true })
			end,
			["zb"] = function()
				neoscroll.zb({ duration = 150, half_win = true })
			end,
		}

		local modes = { "n", "v", "x" }
		for key, func in pairs(keymap) do
			vim.keymap.set(modes, key, func, { silent = true })
		end
	end,
}