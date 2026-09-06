return {
  "3rd/image.nvim",
  ft = { "markdown", "vimwiki", "norg" },
  opts = {
    backend = "kitty", -- Ghostty speaks the Kitty graphics protocol
    processor = "magick_rock", -- "magick_cli" if you have ImageMagick 7's `magick`
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = true,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { "markdown" },
      },
    },
    max_width_window_percentage = 60,
    max_height_window_percentage = 40,
    window_overlap_clear_enabled = true,
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    editor_only_render_when_focused = true,
    tmux_show_only_in_active_window = true,
  },
}
