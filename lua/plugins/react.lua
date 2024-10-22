return {
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        opts = {}
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {
            settings = {
                -- Enable inlay hints
                tsserver_file_preferences = {
                    includeInlayParameterNameHints = 'all',
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                }
            }
        }
    },
    {
        "dsznajder/vscode-react-javascript-snippets",
        build = "yarn install --frozen-lockfile && yarn compile",
        event = "InsertEnter",
    },
    {
        "styled-components/vim-styled-components",
        branch = "main",
        ft = {
            "typescript",
            "javascript",
            "typescriptreact",
            "javascriptreact",
        },
    }
}
