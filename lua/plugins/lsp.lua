return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",    -- Lua
                    "pyright",   -- Python
                    "ts_ls",  -- TypeScript/JavaScript
                    "rust_analyzer" -- Rust
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            -- Configure LSP servers
            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- LSP settings
            local on_attach = function(client, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')



                -- Mappings
                local bufopts = { noremap=true, silent=true, buffer=bufnr }
				local opts = function(desc)
					return vim.tbl_extend("force", bufopts, {desc = desc})
				end
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts("Go to declaration"))
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts("Go to definition"))
				vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts("Go to type definition"))
				vim.keymap.set('n', 'ge', vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Show diagnostics" })
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts("Find references"))
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts("Show hover documentation"))
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts("Go to implementation"))
				vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts("Show signature help"))
				vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts("Rename symbol"))
				vim.keymap.set('n', '<leader>ca', function()
				   vim.lsp.buf.code_action({
					   border = "rounded",
					   style = "minimal",
					   relative = "cursor",
					   focusable = true
				   })
				end, opts("Code actions"))
			end

            -- Setup each LSP server
            local servers = {
                'lua_ls',    -- Lua
                'pyright',   -- Python
                'ts_ls',  -- TypeScript/JavaScript
                'rust_analyzer', -- Rust
            }

            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup {
                    on_attach = on_attach,
                    capabilities = capabilities,
                }
            end

            -- Diagnostic settings
            vim.diagnostic.config({
                virtual_text = false,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
				float = {
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
					style = "minimal",
					focusable = true,
				}
            })

			vim.o.updatetime = 250
			vim.o.signcolumn = "yes" -- Reserve space for diagnostic signs
        end
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp', priority = 1000 },
					{ name = 'luasnip', priority = 750 },
					{ name = 'buffer', priority = 500 },
					{ name = 'path', priority = 250 },
				}),
				completion = {
					completeopt = 'menu,menuone,noinsert'
				},
				max_item_count = 10
            })
        end
    }
}
