return {
	"karb94/neoscroll.nvim",
	opts = {
		mappings = {},
		hide_cursor = true,
		stop_eof = true,
		respect_scrolloff = true,
		cursor_scrolls_alone = true,
		duration_multiplier = 0.8,
		easing = "sine",
		performance_mode = true,
	},
	config = function(_, opts)
		local neoscroll = require("neoscroll")
		neoscroll.setup(opts)

		local function scroll_fraction(fraction, duration)
			local direction = fraction < 0 and -1 or 1
			local lines = math.max(1, math.floor(vim.api.nvim_win_get_height(0) * math.abs(fraction))) * direction
			neoscroll.scroll(lines, { move_cursor = false, duration = duration, easing = "sine" })
		end

		local keymap = {
			["<C-u>"] = function()
				scroll_fraction(-0.45, 110)
			end,
			["<C-d>"] = function()
				scroll_fraction(0.45, 110)
			end,
			["<C-b>"] = function()
				scroll_fraction(-0.9, 160)
			end,
			["<C-f>"] = function()
				scroll_fraction(0.9, 160)
			end,
			["<C-y>"] = function()
				neoscroll.scroll(-3, { move_cursor = false, duration = 60, easing = "sine" })
			end,
			["<C-e>"] = function()
				neoscroll.scroll(3, { move_cursor = false, duration = 60, easing = "sine" })
			end,
			["<ScrollWheelUp>"] = function()
				neoscroll.scroll(-4, { move_cursor = false, duration = 70, easing = "sine" })
			end,
			["<ScrollWheelDown>"] = function()
				neoscroll.scroll(4, { move_cursor = false, duration = 70, easing = "sine" })
			end,
			["zz"] = function()
				neoscroll.zz({ half_win_duration = 100, easing = "sine" })
			end,
			["zt"] = function()
				neoscroll.zt({ half_win_duration = 100, easing = "sine" })
			end,
			["zb"] = function()
				neoscroll.zb({ half_win_duration = 100, easing = "sine" })
			end,
		}

		local modes = { "n", "v", "x" }
		for key, func in pairs(keymap) do
			vim.keymap.set(modes, key, func, { silent = true })
		end
	end,
}
