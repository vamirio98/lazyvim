return {
  "williamboman/mason.nvim",
  opts = {
    install_root_dir = vim.g.lazyvim_data_dir .. (LazyVim.is_win() and "\\" or "/") .. "mason",
  },
}
