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
        always_show = false,

        -- Trim whitespaces from the start/end of each line
        trim_whitespaces = false,

        -- Replace tabs with this many spaces in multiline diagnostics
        tabstop = 4,
      },
    }
    vim.diagnostic.config { virtual_text = false }
  end,
}
