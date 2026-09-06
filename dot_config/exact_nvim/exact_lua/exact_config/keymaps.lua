vim.keymap.set("n", "<leader>zv", function()
  local line = vim.api.nvim_get_current_line()
  local path = line:match("%!%[.-%]%((.-)%)")
  if not path then
    return vim.notify("No image link on this line", vim.log.levels.WARN)
  end
  local dir = vim.fn.expand("%:p:h")
  vim.fn.jobstart({ "xdg-open", vim.fn.fnamemodify(dir .. "/" .. path, ":p") }, { detach = true })
end, { desc = "Open image under cursor " })
