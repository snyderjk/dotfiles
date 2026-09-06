local FALLBACK = vim.fn.expand("~/Documents/vaults/personal")

local function notebook_root()
  local start = vim.fn.expand("%:p:h")
  if start == "" then
    start = vim.fn.getcwd()
  end
  local found = vim.fs.find(".zk", { path = start, upward = true, type = "directory" })[1]
  return found and vim.fs.dirname(found) or FALLBACK
end

-- Returns a path RELATIVE to the current note, e.g. "../zz_assets"
local function assets_relpath()
  local root = notebook_root()
  local note_dir = vim.fn.expand("%:p:h")

  -- Note isn't inside the notebook — bail to a sane default
  if note_dir:sub(1, #root) ~= root then
    return "zz_assets"
  end

  local depth = 0
  for _ in note_dir:sub(#root + 2):gmatch("[^/]+") do
    depth = depth + 1
  end

  return string.rep("../", depth) .. "zz_assets"
end

return {
  "HakonHarnes/img-clip.nvim",
  cmd = { "PasteImage" },
  keys = {
    { "<leader>zP", "<Cmd>PasteImage<CR>", desc = "Paste image into note" },
  },
  opts = {
    default = {
      dir_path = assets_relpath,
      relative_to_current_file = true,
      use_absolute_path = false,
      extension = "png",
      file_name = "%Y%m%d-%H%M%S",
      prompt_for_file_name = false,
      insert_mode_after_paste = true,
    },
    filetypes = {
      markdown = {
        url_encode_path = true,
        template = "![$CURSOR]($FILE_PATH)",
        download_images = true,
      },
    },
  },
}
