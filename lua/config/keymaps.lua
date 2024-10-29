vim.g.mapleader = " "

-- Most important ones to start with
local map = vim.keymap.set

map("n", "<leader>o", "O", { noremap = true, desc = "Insert line above" })
map("n", "<leader>i", "I", { noremap = true, desc = "Insert line below" })
map("n", "<leader>a", "A", { noremap = true, desc = "Goto end of line" })
map("n", "v", "V", { noremap = true, desc = "Visual line mode by default" })
map("n", "<leader>v", "v", { noremap = true, desc = "Visual word mode" })

-- Basic operations
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Navigate to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Navigate to window below" })
map("n", "<C-k>", "<C-w>k", { desc = "Navigate to window above" })
map("n", "<C-l>", "<C-w>l", { desc = "Navigate to right window" })

-- Better indenting
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Move Lines
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

-- Move Lines in Visual Mode
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move block up" })

-- Buffer navigation
map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>x", ":bdelete<CR>", { desc = "Close buffer" })
vim.api.nvim_create_user_command("Open", function(opts)
	if opts.bang then
		vim.cmd("enew | edit " .. opts.args)
	else
		vim.cmd("edit " .. opts.args)
	end
end, { nargs = 1, complete = 'file', bang = true })

-- Window management
map("n", "<leader>vs", ":vsplit<CR>", { desc = "Split vertically" })
map("n", "<leader>hs", ":split<CR>", { desc = "Split horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>sx", ":close<CR>", { desc = "Close current split" })

-- Tab management
map("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", ":tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>tn", ":tabn<CR>", { desc = "Next tab" })
map("n", "<leader>tp", ":tabp<CR>", { desc = "Previous tab" })
