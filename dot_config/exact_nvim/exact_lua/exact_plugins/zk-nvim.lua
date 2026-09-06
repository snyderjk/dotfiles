return {
  "zk-org/zk-nvim",
  lazy = false,
  keys = {},
  config = function()
    local zk = require("zk")
    local commands = require("zk.commands")

    zk.setup({
      -- "telescope" | "fzf" | "fzf_lua" | "minipick" | "snacks_picker" | "select"
      picker = "snacks_picker",
      lsp = {
        config = {
          cmd = { "zk", "lsp" },
          name = "zk",
        },
        auto_attach = {
          enabled = true,
          filetypes = { "markdown" },
        },
      },
    })

    -- ── Helper: prompt for title, then create in a given dir ──
    local function new_in(dir, extra_opts)
      return function()
        vim.ui.input({ prompt = "Title: " }, function(title)
          if not title or title == "" then
            return
          end
          local opts = vim.tbl_extend("force", { dir = dir, title = title }, extra_opts or {})
          zk.new(opts)
        end)
      end
    end

    -- ── Custom commands ──
    commands.add("ZkDaily", function()
      zk.new({ dir = "00_daily" })
    end)

    commands.add("ZkOrphans", function(opts)
      opts = vim.tbl_extend("force", { orphan = true }, opts or {})
      zk.edit(opts, { title = "Orphan notes" })
    end)

    commands.add("ZkInbox", function(opts)
      opts = vim.tbl_extend("force", { hrefs = { "fleeting" }, sort = { "created" } }, opts or {})
      zk.edit(opts, { title = "Inbox" })
    end)

    commands.add("ZkMain", function(opts)
      opts = vim.tbl_extend("force", { hrefs = { "fleeting" }, sort = { "created" } }, opts or {})
      zk.edit(opts, { title = "Main" })
    end)

    -- ── Keymaps ──
    local map = vim.keymap.set

    map("n", "<leader>zn", new_in("01_inbox"), { desc = "zk: fleeting capture" })
    map("n", "<leader>zd", "<Cmd>ZkDaily<CR>", { desc = "zk: today's journal" })
    map("n", "<leader>zp", new_in("03_main"), { desc = "zk: new permanent note" })
    map("n", "<leader>zs", new_in("02_sources"), { desc = "zk: new source note" })

    map("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", { desc = "zk: open note" })
    map("n", "<leader>zi", "<Cmd>ZkInbox<CR>", { desc = "zk: fleeting inbox" })
    map("n", "<leader>zt", "<Cmd>ZkTags<CR>", { desc = "zk: browse tags" })
    map("n", "<leader>zO", "<Cmd>ZkOrphans<CR>", { desc = "zk: orphan notes" })
    map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", { desc = "zk: backlinks" })
    map("n", "<leader>zl", "<Cmd>ZkLinks<CR>", { desc = "zk: outbound links" })
    map("n", "<leader>zI", "<Cmd>ZkInsertLink<CR>", { desc = "zk: insert link" })
    map("v", "<leader>zI", ":'<,'>ZkInsertLinkAtSelection<CR>", { desc = "zk: link selection" })
    map("n", "<leader>zc", "<Cmd>ZkCd<CR>", { desc = "zk: cd to notebook" })
    map("n", "<leader>zR", "<Cmd>ZkIndex<CR>", { desc = "zk: reindex" })

    -- Full-text search across the notebook
    map("n", "<leader>z/", function()
      vim.ui.input({ prompt = "Search: " }, function(q)
        if q then
          zk.edit({ match = { q } }, { title = "Search: " .. q })
        end
      end)
    end, { desc = "zk: search notes" })

    -- ── Visual mode: the two workhorse operations ──
    -- Selection becomes the title of a new note, replaced by a link to it
    map(
      "v",
      "<leader>znt",
      ":'<,'>ZkNewFromTitleSelection { dir = '01_inbox' }<CR>",
      { desc = "zk: new note from selected title" }
    )
    -- Selection becomes the body of a new note; you're prompted for a title
    map(
      "v",
      "<leader>znc",
      ":'<,'>ZkNewFromContentSelection { dir = '01_inbox', title = vim.fn.input('Title: ') }<CR>",
      { desc = "zk: new note from selected content" }
    )
    map("v", "<leader>z/", ":'<,'>ZkMatch<CR>", { desc = "zk: search for selection" })
  end,
}
