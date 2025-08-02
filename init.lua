require("config.lazy")

vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR><cmd>echo \"ran file\"<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
vim.keymap.set("c", "<cr>", function()
  if vim.fn.pumvisible() == 1 then return "<c-y>" end
  return "<cr>"
end, { expr = true })
vim.keymap.set("n", "<enter>", "o<esc>")
vim.keymap.set("i", ")", function()
  local cur_row = vim.fn.getpos(".")[2]
  local cur_col = vim.fn.getpos(".")[3]
  local current_line = vim.fn.getline(".")
  if string.sub(current_line, cur_col, cur_col) == ")" then
    vim.fn.cursor({cur_row, cur_col + 1})
  else
    vim.fn.setline(".", current_line:sub(1, cur_col-1)..")"..current_line:sub(cur_col))
    vim.fn.cursor({cur_row, cur_col + 1})
  end
end)

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
vim.keymap.set("t", "<C-space>", "<C-\\><C-n>")

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.keymap.set("t", "<C-space", function() print("hehe") end)
  end,
})
vim.diagnostic.config({ virtual_text = true })

local job_id = 0
vim.keymap.set("n", "<space>t", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 24)
  job_id = vim.bo.channel
end)

vim.keymap.set("n", "<space>üx", function()
  vim.fn.chansend(job_id, { "echo \'hi\'\r\n" })
end)

vim.keymap.set("n", "<space>sh", "<cmd>Oil<CR>")
vim.keymap.set("n", "<space>sb", "<cmd>e .<CR>")
