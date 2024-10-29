return {
    "nvim-telescope/telescope.nvim",
    dependencies = { 
      "nvim-lua/plenary.nvim"
    },
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<C-f>", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    },
	opts = {
		defaults = {
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.60
				},
				vertical = {
					prompt_position = "top",
					preview_width = 0.60
				},
			},
			file_ignore_patterns ={
				"node_modules",
				"dist",
				"build",
				".git"
			},
			width = 0.90,
			height = 0.90,
			mappings = {
				i = {
                    ["<C-n>"] = false,
                    ["<C-p>"] = false,
                    ["<C-j>"] = require("telescope.actions").move_selection_next,
                    ["<C-k>"] = require("telescope.actions").move_selection_previous,
				}
			},
			buffer_previewer_maker = function(filepath, bufnr, opts)
                -- Disable your Ctrl-J buffer navigation when Telescope is open
                vim.keymap.set('n', '<C-j>', '<Nop>', { buffer = bufnr })
                -- Call the default previewer maker
                require('telescope.previewers').buffer_previewer_maker(filepath, bufnr, opts)
            end,
		}
	}
}
