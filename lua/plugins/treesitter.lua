return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    parser_install_dir = vim.g.lazyvim_data_dir .. "/treesitter",
  },
  init = function()
    vim.opt.runtimepath:prepend(vim.g.lazyvim_data_dir .. "/treesitter")
  end,
}
