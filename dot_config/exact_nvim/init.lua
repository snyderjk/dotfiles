vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.ttimeoutlen = 10

vim.opt.clipboard = "unnamedplus"

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("which-key").add({ { "<leader>z", group = "zettelkasten" } })
