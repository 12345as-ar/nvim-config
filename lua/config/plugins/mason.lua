-- lua/plugins/mason.lua
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "jdtls",
        "lemminx",
        "pyright",
        "cmp_nvim_lsp",
      },
    },
  },
}
