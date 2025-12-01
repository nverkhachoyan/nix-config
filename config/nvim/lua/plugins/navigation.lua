local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({})

vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Buffers" })

require("nvim-tree").setup()
vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>nf", "<cmd>NvimTreeFindFile<cr>", { desc = "Find file in tree" })
vim.keymap.set("n", "<leader>nr", "<cmd>NvimTreeRefresh<cr>", { desc = "Refresh tree" })
vim.keymap.set("n", "<leader>nt", "<cmd>NvimTreeFocus<cr>", { desc = "Focus tree" })
