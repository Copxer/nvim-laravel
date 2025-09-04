return {
    {
        "zbirenbaum/copilot.lua",
        enabled = true,
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = true,
                    auto_refresh = true,
                    keymap = {
                        jump_next = "<c-j>",
                        jump_prev = "<c-k>",
                        accept = "<c-a>",
                        refresh = "r",
                        open = "<M-CR>",
                    },
                    layout = {
                        position = "bottom",
                        ratio = 0.4,
                    },
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 75,
                    keymap = {
                        accept = "<c-a>",
                        accept_word = false,
                        accept_line = false,
                        next = "<c-j>",
                        prev = "<c-k>",
                        dismiss = "<C-e>",
                    },
                },
            })
        end,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        enabled = true,
        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        build = "make tiktoken",
        opts = {},
    },
}
