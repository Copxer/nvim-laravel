-- ~/.config/nvim/lua/plugins/conform.lua
return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ async = true }, function(err, did_edit)
                    if not err and did_edit then
                        vim.notify("Code formatted", vim.log.levels.INFO, { title = "Conform" })
                    end
                end)
            end,
            mode = { "n", "v" },
            desc = "Format buffer",
        },
    },
    opts = {
        --- Prefer LSP if no formatter configured
        default_format_opts = { lsp_format = "fallback" },

        --- Format on save
        format_on_save = { timeout_ms = 1000, lsp_format = "fallback" },

        --- Filetype -> formatters
        formatters_by_ft = {
            -- Go
            go = { "goimports", "gofmt" },

            -- Lua
            lua = { "stylua" },

            -- Web technologies
            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            json = { "prettier" },
            jsonc = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            html = { "prettier" },
            css = { "prettier" },
            scss = { "prettier" },
            vue = { "prettier" },
            xml = { "prettier" },

            -- Python
            python = { "isort", "black" },

            -- PHP/Laravel
            php = { "pint" },

            -- Shell
            sh = { "shfmt" },
            bash = { "shfmt" },

            -- Rust
            rust = { "rustfmt" },

            -- Assembly (NASM/Intel)
            asm = { "nasmfmt_lite" },
            nasm = { "nasmfmt_lite" },
        },

        --- Per-formatter config
        formatters = {
            -- Prefer local node prettier if present
            prettier = {
                command = (function()
                    local local_p = "node_modules/.bin/prettier"
                    return (vim.fn.filereadable(local_p) == 1) and local_p or "prettier"
                end)(),
            },

            -- Laravel Pint (prefer project vendor/bin if available)
            pint = {
                command = (function()
                    return (vim.fn.filereadable("vendor/bin/pint") == 1) and "vendor/bin/pint" or "pint"
                end)(),
                prepend_args = function()
                    return (vim.fn.filereadable("pint.json") == 1) and { "--config", "pint.json" } or {}
                end,
            },

            -- Shell
            shfmt = {
                prepend_args = { "-i", "4", "-ci" }, -- 4-space indent, indent switch cases
            },

            -- Assembly formatter (requires `asmfmt` in PATH)
            nasmfmt_lite = {
                command = "nasmfmt-lite",
                stdin = true,
            },
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
