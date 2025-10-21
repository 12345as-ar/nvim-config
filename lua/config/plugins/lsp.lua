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
      require("lspconfig").pylsp.setup {}
      vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format()
        print("formatted")
      end)
      vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action)
      vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
    end,
  }
}
