return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/nvim-cmp",
	  "pmizzio/typescript-tools.nvim"
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local capabilities = cmp_nvim_lsp.default_capabilities()
	

      -- Simple signature help configuration
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
			border = "rounded",
			highlight = "SignatureActiveParameter",
			focus = false,
			floating_window = {
					transparent = true,
					style = "minimal",
					border = "rounded",
					relative = "cursor",
					row = 1,
					col = 0,
					height = nil,
					width = nil,
				},
        }
      )

      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
        
        -- Buffer local mappings
        local opts = { buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set({'n', 'i'}, '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

        if client.server_capabilities.signatureHelpProvider then
          vim.api.nvim_create_autocmd("TextChangedI", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.signature_help()
            end,
          })
        end
      end

	  -- ESLint
		lspconfig.eslint.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				workingDirectory = { mode = "auto" }
			},
			root_dir = lspconfig.util.root_pattern(
				".eslintrc",
				".eslintrc.js",
				".eslintrc.json"
			)
		})

		-- Setup typescript-tools instead of tsserver
		require("typescript-tools").setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				expose_as_code_action = "all",
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "all",
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeCompletionsForModuleExports = true,
					importModuleSpecifierPreference = "relative",
					quotePreference = "single",
					includeCompletionsForModuleExports = true,
				},
				separate_diagnostic_server = true,  -- Better performance
				expose_as_code_action = "all",       -- Access to all code actions
				tsserver_flags = {
					"--maxMemory", "4096",
					"--watchOptions", '{"watchFile":"useFsEvents","watchDirectory":"useFsEvents"}',
				},
			}
		})

    end
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
		  ['<Tab>'] = function(fallback)
			  if cmp.visible() then
				cmp.select_next_item()
			  else
				  fallback()
			  end
		  end,
		  ['<S-Tab>'] = function(fallback)
			  if cmp.visible() then
				cmp.select_prev_item()
			  else
				  fallback()
			  end
		  end,
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        })
      })
    end
  },
  {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.diagnostics.eslint,
                }
            })
        end
    }
}
