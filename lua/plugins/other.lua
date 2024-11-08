return {
    {
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "│" },
                    change = { text = "│" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    -- Navigation between changes
                    vim.keymap.set('n', ']c', gs.next_hunk, { buffer = bufnr })
                    vim.keymap.set('n', '[c', gs.prev_hunk, { buffer = bufnr })
                    -- Stage/unstage changes
                    vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { buffer = bufnr })
                    vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { buffer = bufnr })
                    -- Preview changes
                    vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr })
                end,
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = 'solarized',
                    globalstatus = true,
                },
            })
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup({})  -- Using defaults
        end,
    },
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                size = 20,
                direction = "float",
                float_opts = {
                    border = "curved",
                },
            })

            -- Terminal navigation
            vim.keymap.set({'n', 't'}, '<C-\\>', '<Cmd>ToggleTerm<CR>', { buffer = 0 })
            vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { buffer = 0 })
            vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { buffer = 0 })
            vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { buffer = 0 })
            vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { buffer = 0 })
        end,
    },
}
