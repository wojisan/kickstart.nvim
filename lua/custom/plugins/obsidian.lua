return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- use latest release, remove to use latest commit
  lazy = true,
  ft = 'markdown',
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in the next major release
    -- inside your obsidian-nvim config
    -- ... other config ...
    checkboxes = {
      order = { ' ', 'x' },
      mappings = {
        [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
        ['x'] = { char = '', hl_group = 'ObsidianDone' },
      },
    },
    -- Fixes NFS mount issues
    -- use_advanced_uri = true,

    ui = {
      enable = false, -- set to false to disable all UI features
      update_debounce = 200, -- manage how often UI updates
    },
    workspaces = {
      {
        name = 'personal',
        path = '~/Documents/Notes/logseq',
      },
    },
    -- configuration for daily notes (per Gemini, so probably wrong)
    daily_notes = {
      folder = 'journals',
    },
    picker = {
      name = 'telescope.nvim',
      note_mappings = {
        new = '<C-x>', -- Create a new note from the search string
        insert_link = '<C-x>', -- Insert a link to the selected note
      },
    },

    -- Disabling internal completion to prioritize markdown-oxide
    completion = {
      nvim_cmp = false,
      min_chars = 2,
    },
  },
  -- added by recommendation of Gemini to deal with conceallevels
  config = function(_, opts)
    require('obsidian').setup(opts)

    -- try some key bindings
    vim.keymap.set('n', '<leader>o', ':Obsidian<CR>', { desc = '[o]bsidian' })
    vim.keymap.set('n', '<leader>ot', ':Obsidian today<CR>', { desc = '[o]bsidian [t]oday' })
    vim.keymap.set('n', '<leader>os', ':Obsidian search<CR>', { desc = '[o]bsidian [s]earch' })
    -- This is the "Nuclear Option" to kill the warning:
    -- It forces the level to 2 ONLY when you are in a Markdown file.
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        vim.opt_local.conceallevel = 2
        vim.opt_local.writebackup = false
        vim.opt_local.backupcopy = 'yes'
      end,
    })
  end,
}
