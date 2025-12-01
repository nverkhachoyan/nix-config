local catppuccin = require("catppuccin")

catppuccin.setup({
    flavour = "mocha",
})
vim.cmd.colorscheme("catppuccin")

vim.keymap.set("n", "<leader>tt", function()
    local current = catppuccin.get_flavour()
    local new_flavour = current == "mocha" and "latte" or "mocha"
    catppuccin.setup({ flavour = new_flavour })
    vim.cmd.colorscheme("catppuccin")
end, { desc = "Toggle theme" })
