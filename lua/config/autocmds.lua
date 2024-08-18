-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true  })
end

local autocmd = vim.api.nvim_create_autocmd

local keyset = vim.keymap.set

-- nvim does not delete the tmp file in shada dir automatically, if the number of tmp file is large than 26,
-- there will be an error when close the nvim that say "main.shada.tmp.X files exist, cannot write ShaDa file!"
local function clear_tmp_shada_files()
	local shada_path = vim.fn.expand(vim.fn.stdpath("data") .. "/shada")
	local files = vim.fn.glob(shada_path .. "/*", false, true)
	local last_modified = {} ---@type {time: number, path: string}
	local not_found = {}
	for _, file in ipairs(files) do
		local file_name = vim.fn.fnamemodify(file, ":t")
		if file_name ~= "main.shada" then -- skip the main.shada file
			local t = vim.fn.getftime(file)
			if t == -1 then
				table.insert(not_found, 1, file)
			else
				table.insert(last_modified, 1, { time = t, path = file })
			end
		end
	end

	-- delete some oldest tmp file
	local max_keep = 10 -- keep the last 10 tmp files
	local err = {}
	local ok = {}
	if #last_modified > max_keep then
		table.sort(last_modified, function(a, b)
			return a.time > b.time
		end)
		for i = max_keep + 1, #last_modified do
			table.insert(vim.fn.delete(last_modified[i].path) == 0 and ok or err, 1, last_modified[i].path)
		end
	end
	if #ok ~= 0 then
		LazyVim.info(ok, { title = string.format("Successfully delete %d tmp ShaDa files:", #ok) })
	end
	if #err ~= 0 then
		LazyVim.error(err, { title = string.format("Can't delete %d files:", #err) })
	end
	if #not_found ~= 0 then
		LazyVim.error(not_found, { title = string.format("Can't found %d files:", #not_found) })
	end
end
autocmd("VimEnter", {
	group = augroup("clear_tmp_shada_files"),
	once = true,
	callback = function()
		local timer = vim.uv.new_timer()
		---@diagnostic disable-next-line: need-check-nil
		timer:start(1000, 0, function()
			---@diagnostic disable-next-line: need-check-nil
			timer:stop()
			vim.schedule(function()
				clear_tmp_shada_files()
			end)
		end)
	end,
})