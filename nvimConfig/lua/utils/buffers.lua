local M = {}

function M.delete(buf)
	local current = buf or vim.api.nvim_get_current_buf()

	if vim.bo[current].modified then
		vim.notify("Buffer has unsaved changes", vim.log.levels.WARN)
		return
	end

	local listed_buffers = vim.tbl_filter(function(candidate)
		return candidate ~= current and vim.api.nvim_buf_is_loaded(candidate) and vim.bo[candidate].buflisted
	end, vim.api.nvim_list_bufs())

	if vim.api.nvim_get_current_buf() == current then
		if #listed_buffers > 0 then
			vim.cmd.buffer(listed_buffers[#listed_buffers])
		else
			vim.cmd.enew()
		end
	end

	vim.cmd.bdelete(current)
end

return M
