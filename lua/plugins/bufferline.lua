-- lua/plugins/bufferline.lua
return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons', -- Enables icons
  config = function()
    require("bufferline").setup({
      options = {
		  close_command = function(bufnum)
			local alternate = vim.fn.bufnr('#')
			if alternate > 0 and alternate ~= bufnum and vim.fn.buflisted(alternate) == 1 then
				vim.cmd('buffer ' .. alternate)
			else
				vim.cmd('bnext')
			end
			vim.cmd(string.format('bdelete! %d', bufnum))
	      end,
		  persist_buffer_sort = true,
		  show_buffer_close_icons = true,
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
    vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', {})
    vim.keymap.set('n', '<leader>q', '<cmd>bd<CR>', {})
    vim.keymap.set('n', '<leader>wq', '<cmd>wq<CR>', {})
  end,
}
