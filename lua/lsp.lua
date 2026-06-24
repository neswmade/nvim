local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("mini.completion").get_lsp_capabilities())

vim.lsp.config("*", { capabilities = capabilities })

-- lua
vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    settings = {
        Lua = {
            diagnostics = { globals = {"vim"} },
        },
    },
})

vim.lsp.enable({
    "lua_ls",
})
