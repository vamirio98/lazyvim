return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      {
        "honza/vim-snippets",
        config = function()
          require("luasnip.loaders.from_snipmate").lazy_load()
        end,
      },
    },
  },
  {
    "nvim-cmp",
    keys = {
      {
        "<C-l>",
        function()
          return require("luasnip").expand()
        end,
        silent = true,
        mode = "i",
      },
      {
        "<C-j>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<C-j>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<C-j>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
      },
      {
        "<C-k>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
      },
    },
  },
  {
    "rafamadriz/friendly-snippets",
    enabled = false,
  },
}
