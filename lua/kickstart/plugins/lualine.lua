--Full(ish) setup using example at https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/bubbles.lua

--I started messing with it and like it so its staying
--this could be seperated into a more modular approach

--The default setup was pretty good if you want to just use
--the default un-comment untill line before --<<HERE

-- return {
--   'nvim-lualine/lualine.nvim',
--   dependencies = { 'nvim-tree/nvim-web-devicons' },
--   config = function()
--     require('lualine').setup {}
--   end,
-- }

--<<HERE
-- --Then comment or delete the rest of the file.
--

-- Set up colors for our custom theme
local colors = {
  yellow = '#c9aa0a',
  orange = '#d4722c',
  blue = '#80a0ff',
  green = '#20cc20',
  black = '#080808',
  white = '#c6c6c6',
  red = '#ff5189',
  violet = '#d183e8',
  grey = '#303030',
}

--define our custom theme
local bubbles_theme = {

  --colors for normal mode
  normal = {
    a = { fg = colors.black, bg = colors.blue },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },
  --colors for command mode
  command = {
    a = { fg = colors.black, bg = colors.orange },
  },
  --colors for insert mode
  insert = { a = { fg = colors.black, bg = colors.blue } },
  --colors for visual mode
  visual = { a = { fg = colors.black, bg = colors.green } },
  --colors for select mode
  --TODO: fix so color changes when in select mode
  --currently uses the color from visual mode
  select = { a = { fg = colors.black, bg = colors.yellow } },
  --colors for replace mode
  replace = { a = { fg = colors.black, bg = colors.red } },
  --colors for sections when window is inactive
  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
} --> bubbles_theme

--Function to use gitsigns in our status line
--The default seemed fine so this is more of
--an example then necessary in any way
local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end -->diff_source()

-- LuaLine has sections as shown below
--
-- +-------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-- +-------------------------------------------------+
--

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        --colors from our custom theme
        --if you want it to try to use
        --colors from your vim theme
        --then switch bubbles_theme to auto
        theme = bubbles_theme,
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
      --define what we want in each section
      sections = {
        lualine_a = { { 'mode', separator = { left = '', right = '' }, right_padding = 2 } },
        lualine_b = {
          'filename',
          --use gitSigns for our branch
          { 'b:gitsigns_head', icon = '' },
          --and use our funcion for diff
          { 'diff', source = diff_source },
        },
        --Currently unused section
        lualine_c = {
          '%=', --[[ add your center compoentnts here in place of this comment ]]
        },
        --Currently unused section
        lualine_x = {},
        lualine_y = { 'filetype', 'progress' },
        lualine_z = {
          { 'location', separator = { right = '' }, left_padding = 2 },
        },
      },
      --Sections that remain displayed when not the active view
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
      --I do not use tabs but I assume you can configure that here
      tabline = {},
      --load builtin extensions. check out the others!
      extensions = { 'man', 'lazy', 'neo-tree' },
    }
  end,
}
