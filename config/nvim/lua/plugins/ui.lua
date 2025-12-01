require("lualine").setup({
    options = { theme = "catppuccin" },
})

require("trouble").setup()
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle trouble" })
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace diagnostics" })
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document diagnostics" })

require("nvim-surround").setup()

require("nvim-treesitter.configs").setup({
    ensure_installed = {},
    highlight = { enable = true },
})
