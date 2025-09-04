-- lua/plugins/opencode.lua
return {
    "NickvanDyke/opencode.nvim",
    dependencies = { "folke/snacks.nvim" }, -- required
    ---@type opencode.Config
    opts = {
        -- Add your favorite quick prompts here (optional)
        prompts = {
            review = {
                description = "Review current buffer",
                prompt = "Review @buffer and suggest improvements with examples.",
            },
            todo = {
                description = "Summarize TODOs in file",
                prompt = "Scan @buffer and list TODO/FIXME with line numbers.",
            },
        },
    },
    keys = {
        -- Toggle the embedded OpenCode TUI
        {
            "<leader>ot",
            function()
                require("opencode").toggle()
            end,
            desc = "OpenCode: Toggle TUI",
        },

        -- Ask (normal/visual)
        {
            "<leader>oa",
            function()
                require("opencode").ask()
            end,
            desc = "OpenCode: Ask",
            mode = "n",
        },
        {
            "<leader>oa",
            function()
                require("opencode").ask("@selection: ")
            end,
            desc = "OpenCode: Ask about selection",
            mode = "v",
        },

        -- Pick a saved prompt (works in normal/visual)
        {
            "<leader>op",
            function()
                require("opencode").select_prompt()
            end,
            desc = "OpenCode: Select prompt",
            mode = { "n", "v" },
        },

        -- Session & UI helpers
        {
            "<leader>on",
            function()
                require("opencode").command("session_new")
            end,
            desc = "OpenCode: New session",
        },
        {
            "<leader>oy",
            function()
                require("opencode").command("messages_copy")
            end,
            desc = "OpenCode: Copy last reply",
        },
        {
            "<S-C-u>",
            function()
                require("opencode").command("messages_half_page_up")
            end,
            desc = "OpenCode: Scroll up",
        },
        {
            "<S-C-d>",
            function()
                require("opencode").command("messages_half_page_down")
            end,
            desc = "OpenCode: Scroll down",
        },
    },
}
