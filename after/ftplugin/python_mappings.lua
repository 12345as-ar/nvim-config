
print("hello I know that you are editing a python file and am aplying your settings for that")

local spawn_bottom_terminal = function()
  local job_id = 0
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 24)
  job_id = vim.bo.channel
  return job_id
end

vim.keymap.set("n", "<space>t", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 24)
end)




vim.keymap.set("n", "<space>px", function()
  vim.cmd.write()
  local filename
  filename = vim.fn.expand('%:t')
  print(filename)
  local job_id = spawn_bottom_terminal()
  vim.fn.chansend(job_id, { "prun " .. filename .. "\r\n" })
end)

vim.keymap.set("n", "<space>f", function ()
  vim.cmd.write()
  vim.cmd [[
    !black -l 79 --preview %
  ]]
end)
