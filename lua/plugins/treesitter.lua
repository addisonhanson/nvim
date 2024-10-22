return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
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
                autotag = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            })
        end,
    }
}
