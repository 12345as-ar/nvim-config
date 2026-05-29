return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            python = { "black" },
        },
    },

    config = function(_, opts)
        require("conform").setup(opts)

        vim.keymap.set("n", "<leader>f", function()
            require("conform").format({ async = true })
        end)
    end,
}
