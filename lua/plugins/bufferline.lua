-- lua/plugins/bufferline.lua
return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons', -- Enables icons
  config = function()
    require("bufferline").setup({
      options = {
		  style_preset = require("bufferline").style_preset.minimal,

		  separator_style = "slant",
		  show_buffer_icons = true,
		  close_icon = '\u{F0049}',
		  show_close_icon = true,

        }
    })
    
    -- Key mappings for bufferline
    vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
    vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
  end,
}
