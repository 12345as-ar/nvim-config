return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    } },
    config = function()
      require("lspconfig").lua_ls.setup {}
      require("lspconfig").clangd.setup {}
      vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format()
        print("formatted")
      end)
    end,
  }
}
