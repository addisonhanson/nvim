-- lua/plugins/bufferline.lua
return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons', -- Enables icons
  config = function()
    require("bufferline").setup({
      options = {
		  offsets = {
			  {
				  filetype = "NvimTree",
				  text = "Files",
				  separator = true,
			  }
		  },
		  separator_style = "thin",
		  show_buffer_icons = true,
		  close_icon = '\u{F0049}',
		  show_close_icon = true,
		  close_command = "bdelete! %d",
	      right_mouse_command = "bdelete! %d",
		  left_mouse_command = "buffer %d", 
		  middle_mouse_command = nil,      
		  diagnostics = "nvim_lsp",
		  move_wraps_at_end = true,
		  always_show_bufferline = true,
        },
    })
    
    -- Key mappings for bufferline
    vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
    vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
  end,
}
