return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
          }
        },
        extenxions = {
          fzf = {}
        }
      }
      vim.keymap.set("n", "<space>sd", ":cd %:p:h<CR>")
      vim.keymap.set("n", "<space>sh", require("telescope.builtin").help_tags)
      vim.keymap.set("n", "<space>sn", require("telescope.builtin").find_files)
      vim.keymap.set("n", "<space>sen", function()
        require("telescope.builtin").find_files {
          cwd = vim.fn.stdpath("config")
        }
      end)
      require("config.telescope.multigrep").setup()
    end
  }
}
