require("vim._core.ui2").enable({})

-- load plugins
vim.pack.add({ 'https://github.com/nvim-mini/mini.files' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.completion' })

-- lua/ files
require("options")
require("treesitter")
require("keymaps")

-- init plugins
require("mini.files").setup({
    mappings = {
        go_in = "<CR>",
        go_in_plus = "L",
        go_out = "_",
        go_out_plus = "H"
    },
})

require("mini.completion").setup({
    lsp_completion = {
        auto_setup = true,
        process_items = function(items, base)
            return require("mini.completion").default_process_items(items, base, {
                filtersort = "fuzzy",
            })
        end,
    }
})
