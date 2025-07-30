require("config.lazy")

vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
vim.keymap.set("c", "<cr>", function()
    if vim.fn.pumvisible() == 1 then return "<c-y>" end
    return "<cr>"
end, { expr = true })
vim.keymap.set("n", "<enter>", "o<esc>")

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
    	vim.highlight.on_yank()
    end,
})
vim.diagnostic.config({ virtual_text = true })
