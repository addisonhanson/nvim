return {
    'ray-x/aurora',
	priority = 1000,
    init = function()
      vim.g.aurora_italic = 1
      vim.g.aurora_darker = 1
      vim.g.aurora_underline = 1
      vim.g.aurora_bold = 1
	  vim.g.aurora_undercurl = 1
	  vim.g.aurora_enable_telescope = 1
	  vim.g.aurora_enable_tree = 1
    end,
    config = function()
        vim.cmd.colorscheme "aurora"
        -- override defaults
        vim.api.nvim_set_hl(0, '@number', {fg='#e933e3'})
    end
}
