return {
  "abecodes/tabout.nvim",
  opts = {
    tabkey = "",
    backwards_tabkey = "",
  },
  config = function(_, opts)
    require("tabout").setup(opts)
    vim.keymap.set("i", "<A-x>", "<Plug>(TaboutMulti)", { silent = true })
    vim.keymap.set("i", "<A-z>", "<Plug>(TaboutBackMulti)", { silent = true })
  end,
}
