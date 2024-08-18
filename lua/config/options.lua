-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
if LazyVim.is_win() then
  LazyVim.terminal.setup("pwsh")
end
local opt = vim.opt

opt.background = "light"
