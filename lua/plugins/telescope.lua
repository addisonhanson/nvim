return {
    "nvim-telescope/telescope.nvim",
    dependencies = { 
      "nvim-lua/plenary.nvim",
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make'
		}
    },
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<C-f>", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
	  { "<leader>fs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
	  { "<leader>vs", "<cmd>vsplit ", desc = "remapped vsplit, can type" },
	  { "<leader>vsb", "<cmd>vsplit | Telescope buffers<cr>", desc = "Select open buffer for vsplit" },
	  { "<leader>hsb", "<cmd>split | Telescope buffers<cr>", desc = "Select open buffer for split" },
	  { "<leader>vs", "<cmd>vsplit | Telescope find_files<cr>", desc = "Select file for vsplit" },
	  { "<leader>hs", "<cmd>split | Telescope find_files<cr>", desc = "Select file for split" },

    },
    config = function(_, opts)
        local telescope = require('telescope')
        
        -- Merge default opts with fzf extension settings
        opts.extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            }
        }
        
        -- Setup telescope with merged opts
        telescope.setup(opts)
        
        -- Load fzf extension
        telescope.load_extension('fzf')
    end,
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
