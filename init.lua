require("config.lazy")

vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"

-- rename is grn grr is idk

-- debugger

local dap, dapui =require("dap"),require("dapui")
dap.listeners.after.event_initialized["dapui_config"]=function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"]=function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"]=function()
  dapui.close()
end

vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

vim.keymap.set('n', '<F5>', function()
  require 'dap'.continue()
  require ("dapui").open()
end
)
vim.keymap.set('n', '<F10>', require 'dap'.step_over)
vim.keymap.set('n', '<F11>', require 'dap'.step_into)
vim.keymap.set('n', '<F12>', require 'dap'.step_out)
vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)

-- end debugger

vim.keymap.set("n", "<space><esc>", "<cmd>noh<CR>") -- clear search term
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR><cmd>echo \"ran file\"<CR>") -- run lua at root
vim.keymap.set("n", "<space>x", ":.lua<CR>") -- run lua file 
vim.keymap.set("v", "<space>x", ":lua<CR>") -- run lua selection


-- dont remember but it makes typing commands better
vim.keymap.set("c", "<cr>", function()
  if vim.fn.pumvisible() == 1 then return "<c-y>" end
  return "<cr>"
end, { expr = true })

vim.keymap.set("n", "<enter>", "o<esc>") -- newline with enter

-- exit brackets by typing brackets
vim.keymap.set("i", ")", function()
  local cur_row = vim.fn.getpos(".")[2]
  local cur_col = vim.fn.getpos(".")[3]
  local current_line = vim.fn.getline(".")
  if string.sub(current_line, cur_col, cur_col) == ")" then
    vim.fn.cursor({ cur_row, cur_col + 1 })
  else
    vim.fn.setline(".", current_line:sub(1, cur_col - 1) .. ")" .. current_line:sub(cur_col))
    vim.fn.cursor({ cur_row, cur_col + 1 })
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

-- exit terminal mode
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.keymap.set("t", "<C-space", function() print("hehe") end)
  end,
})


vim.diagnostic.config({ virtual_text = true })
vim.keymap.set("n", "<space>e", function() --jump through errors
  vim.diagnostic.jump({ count = 1 })
  print("next")
end
)


vim.keymap.set("n", "<space>t", function()-- open terminal
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 24)
end)


vim.keymap.set("n", "<space>sh", "<cmd>Oil<CR>") -- open oil 
vim.keymap.set("n", "<space>sb", "<cmd>e .<CR>") -- open oil at source
