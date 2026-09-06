return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = { "markdown" },
  opts = {
    link = {
      enabled = true,
      image = "󰥶 ",
      hyperlink = "󰌷 ",
      wiki = { icon = "󱗖 " },
    },
    heading = { sign = false },
    code = { sign = false, width = "block" },
    win_options = {
      conceallevel = { default = 0, rendered = 3 },
      concealcursor = { default = "", rendered = "nc" },
    },
  },
}
