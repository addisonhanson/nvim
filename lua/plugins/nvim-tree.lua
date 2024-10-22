return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {"nvim-tree/nvim-web-devicons",},
  config = function()
    require("nvim-tree").setup {
		git = {
			enable = false
		},
		renderer = {
			icons = {
				show = {
					git = false,
					file = true,
					folder = true, 
					folder_arrow = true,
				},
			},
		},
	   	view = {
			width = 35,
			preserve_window_proportions = false,
		},
      	actions = {
			open_file = {
			  resize_window = true,
			},
      	},
	}

	vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
  end,
}
