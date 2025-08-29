return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  priority = 1000,
  config = function()
    require('tiny-inline-diagnostic').setup {
      preset = 'powerline',
      multilines = {
        -- Enable multiline diagnostic messages
        enabled = true,

        -- Always show messages on all lines for multiline diagnostics
        always_show = true,

        -- Trim whitespaces from the start/end of each line
        trim_whitespaces = false,

        -- Replace tabs with this many spaces in multiline diagnostics
        tabstop = 4,
      },
      break_line = {
        -- Enable breaking messages after a specific length
        enabled = true,

        -- Number of characters after which to break the line
        after = 25,
      },
    }
    vim.diagnostic.config { virtual_text = false }
  end,
}
