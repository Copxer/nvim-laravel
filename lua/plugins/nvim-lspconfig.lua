return {
    "neovim/nvim-lspconfig",
    lazy = false, -- ensure it's loaded early
    priority = 1000, -- ensure it's before LSP configs that require it
}
