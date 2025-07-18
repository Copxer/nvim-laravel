local util = require("lspconfig.util")
local blink = require("blink.cmp")

local function get_intelephense_license()
    local license_path = os.getenv("HOME") .. "/intelephense/license.txt"
    local f = io.open(license_path, "rb")
    if not f then
        vim.notify("⚠️ intelephense license.txt not found at: " .. license_path, vim.log.levels.WARN)
        return ""
    end
    local content = f:read("*a")
    f:close()
    return content:gsub("%s+", "")
end

return {
    cmd = { "intelephense", "--stdio" },
    filetypes = { "php", "blade" },
    init_options = {
        licenceKey = get_intelephense_license(),
    },
    capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        blink.get_lsp_capabilities()
    ),
}
