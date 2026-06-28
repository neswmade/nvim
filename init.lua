require("options")
require("treesitter")

require("vim._core.ui2").enable({})

-- nesw-dark | nesw-dark-soft | nesw-light | nesw-light-soft
vim.cmd.colorscheme("nesw-dark")

-- load plugins
vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })

vim.pack.add({ 'https://github.com/mason-org/mason.nvim' })
vim.pack.add({ 'https://github.com/mason-org/mason-lspconfig.nvim' })
vim.pack.add({ 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' })

vim.pack.add({ 'https://github.com/nvim-mini/mini.files' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.completion' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.notify' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.cmdline' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.surround' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.snippets' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.pick' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.extra' })

-- initialize plugins
local MiniFiles = require("mini.files")
MiniFiles.setup({
    mappings = {
        go_in = "<CR>",
        go_in_plus = "L",
        go_out = "_",
        go_out_plus = "H"
    },
})

local MiniNotify = require("mini.notify")
MiniNotify.setup({
    content = { format = function(notif) return notif.msg end },
})

local MiniComplete = require("mini.completion")
MiniComplete.setup({
    lsp_completion = {
        auto_setup = true,
        process_items = function(items, base)
            return require("mini.completion").default_process_items(items, base, {
                filtersort = "fuzzy",
            })
        end,
    }
})

local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({
    snippets = { MiniSnippets.gen_loader.from_lang() },
})
MiniSnippets.start_lsp_server({ match = false })

require("mini.pick").setup()
require("mini.extra").setup()
require("mini.cmdline").setup()
require("mini.surround").setup()

require("mason").setup()

require("mason-lspconfig").setup()

-- ensure installed lsps
require("mason-tool-installer").setup({
    ensure_installed = {
        "lua_ls",
        "stylua",
        "marksman",
        "clangd",
    }
})

-- load keymaps and lsp config last
require("keymaps")
require("lsp")
