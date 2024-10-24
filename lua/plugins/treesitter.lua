return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "lua",
                    "vim",
                    "typescript",
                    "javascript",
                    "tsx",
                    "json",
                    "css",
                    "html",
                },
                auto_install = true,
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            })
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require('nvim-ts-autotag').setup()
        end,
    }
}
