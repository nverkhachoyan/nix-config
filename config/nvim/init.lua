vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("core.options")
require("core.keymaps")

require("plugins.theme")
require("plugins.navigation")
require("plugins.ui")
require("plugins.cmp")
require("plugins.lint")
require("plugins.lsp")
