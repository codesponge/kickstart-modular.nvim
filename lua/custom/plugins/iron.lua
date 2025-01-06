return {
  'hkupty/iron.nvim',
  config = function()
    local iron = require 'iron.core'

    iron.setup {
      config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
          sh = {
            -- Can be a table or a function that
            -- returns a table (see below)
            command = { 'zsh' },
          },
          python = {
            --command = { 'python3' },
            command = { 'ipython', '--no-autoindent' },
            format = require('iron.fts.common').bracketed_paste_python,
          },
        },
        -- How the repl window will be displayed
        -- See below for more information
        --repl_open_cmd = require('iron.view').bottom(40),
        repl_open_cmd = require('iron.view').split.vertical.botright(83),
      },

      --NOTE: setting keymaps directly further in the file
      --keeping these here for reference (for now).

      -- keymaps = {
      --   send_motion = '<F2>sc',
      --   visual_send = '<F2>sc',
      --   send_file = '<F2>sf',
      --   send_line = '<F2>sl',
      --   send_mark = '<F2>sm',
      --   mark_motion = '<F2>mc',
      --   mark_visual = '<F2>mc',
      --   remove_mark = '<F2>md',
      --   cr = '<F2>s<cr>',
      --   interrupt = '<F2>s<space>',
      --   exit = '<F2>sq',
      --   clear = '<F2>cl',
      -- },

      -- If the highlight is on, you can change how it looks
      -- For the available options, check nvim_set_hl
      highlight = {
        italic = true,
      },
      ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
    }

    --INFO: KEYMAPS
    --setting the keymaps this more verbose way so we can add descriptions

    --INFO: Keymaps for: basic interaction with the repl

    --send motion
    --sends code from motion commands
    --ie <F2>sc3j -> will send three line down from cursor
    vim.keymap.set('n', '<F2>sc', function()
      require('iron.core').run_motion 'send_motion'
    end, { desc = 'REPL send -> motion' })

    --send mark
    vim.keymap.set('n', '<F2>sm', iron.send_mark, { desc = 'REPL send -> mark' })

    --send line
    vim.keymap.set('n', '<F2>sl', iron.send_line, { desc = 'REPL send -> line' })

    --send until_cursor
    vim.keymap.set('n', '<F2>sh', iron.send_until_cursor, { desc = 'REPL send -> until_cursor' })

    --send file
    vim.keymap.set('n', '<F2>sf', iron.send_file, { desc = 'REPL send -> file' })

    --send paragraph
    vim.keymap.set('n', '<F2>sp', iron.send_paragraph, { desc = 'REPL send -> paragraph' })

    --send visual
    vim.keymap.set('v', '<F2>sc', iron.visual_send, { desc = 'REPL send -> visual' })

    --INFO: Keymaps for: Marks

    --mark motion
    vim.keymap.set('n', '<F2>m', function()
      require('iron.core').run_motion 'mark_motion'
    end, { desc = 'REPL set mark with motion' })

    --mark visual
    vim.keymap.set('v', '<F2>m', iron.mark_visual, { desc = 'REPL set mark with visual' })

    --remove mark
    vim.keymap.set('n', '<F2>dm', require('iron.marks').drop_last, { desc = 'REPL delete mark' })

    --INFO: Keymaps for sending special chars to the repl

    --send carriage return <cr>
    vim.keymap.set('n', '<F2>s<cr>', function()
      iron.send(nil, string.char(13))
    end, { desc = 'REPL send -> <cr>' })

    --send interrupt
    vim.keymap.set('n', '<F2>s<space>', function()
      iron.send(nil, string.char(03))
    end, { desc = 'REPL send -> interrupt' })

    --send exit
    vim.keymap.set('n', '<F2>X', iron.close_repl, { desc = 'REPL e[X]it' })

    --send clear
    vim.keymap.set('n', '<F2>cl', function()
      iron.send(nil, string.char(12))
    end, { desc = 'REPL clear screen' })

    -- iron also has a list of commands, see :h iron-commands for all available commands
    vim.keymap.set('n', '<F2>rs', '<cmd>IronRepl<cr>')
    vim.keymap.set('n', '<F2>rr', '<cmd>IronRestart<cr>')
    vim.keymap.set('n', '<F2>rf', '<cmd>IronFocus<cr>')
    vim.keymap.set('n', '<F2>rh', '<cmd>IronHide<cr>')
  end,
}
