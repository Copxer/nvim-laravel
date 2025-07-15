return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- LSP status
            local function lsp_status()
                local bufnr = vim.api.nvim_get_current_buf()
                local clients = vim.lsp.get_clients({ bufnr = bufnr })
                if #clients == 0 then
                    return ""
                end

                local names = {}
                for _, client in ipairs(clients) do
                    table.insert(names, client.name)
                end
                return "󰒋 " .. table.concat(names, ",")
            end

            -- Git branch
            local function git_branch()
                local ok, handle = pcall(io.popen, "git branch --show-current 2>/dev/null")
                if not ok or not handle then
                    return ""
                end
                local branch = handle:read("*a")
                handle:close()
                if branch and branch ~= "" then
                    branch = branch:gsub("\n", "")
                    return "󰊢 " .. branch
                end
                return ""
            end

            -- Formatter status (from conform.nvim)
            local function formatter_status()
                local ok, conform = pcall(require, "conform")
                if not ok or vim.bo.filetype == "" then
                    return ""
                end

                local formatters = conform.list_formatters_to_run(0)
                if #formatters == 0 then
                    return ""
                end

                local names = {}
                for _, f in ipairs(formatters) do
                    table.insert(names, f.name)
                end
                return "󰉿 " .. table.concat(names, ",")
            end

            -- Linter status (from nvim-lint)
            local function linter_status()
                local ok, lint = pcall(require, "lint")
                if not ok or vim.bo.filetype == "" then
                    return ""
                end

                local linters = lint.linters_by_ft[vim.bo.filetype] or {}
                if #linters == 0 then
                    return ""
                end

                return "󰁨 " .. table.concat(linters, ",")
            end

            -- Safe wrappers
            local function safe(fn)
                return function()
                    local ok, result = pcall(fn)
                    return ok and result or ""
                end
            end

            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { safe(git_branch) },
                    lualine_c = {
                        { "filename", path = 1 }, -- relative path
                        {
                            function()
                                return vim.bo.modified and "[+]" or ""
                            end,
                        },
                        {
                            function()
                                return vim.bo.readonly and "[RO]" or ""
                            end,
                        },
                    },
                    lualine_x = {
                        safe(linter_status),
                        safe(formatter_status),
                        safe(lsp_status),
                        { "diagnostics" }, -- Uncomment if you want native diagnostics here
                    },
                    lualine_y = { "location" }, -- line:column
                    lualine_z = { "progress" }, -- percent through file
                },
            })
        end,
    },
}
