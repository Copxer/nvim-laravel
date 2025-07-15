-- Description: Main entry point for the Neovim configuration.
function _G.linter_status()
    return "Linter: ✅" -- replace with actual logic if needed
end

function _G.formatter_status()
    return "Formatter: ✨" -- replace with actual logic if needed
end

function _G.lsp_status()
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    if #clients == 0 then
        return "LSP: Off"
    end
    return "LSP: On"
end

require("core.mason-path")

require("core.lsp")

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.mason-verify")
require("config.health-check")

require("core.lazy")
