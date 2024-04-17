return function()
    local lsp_zero = require("lsp-zero")

    lsp_zero.on_attach(function(_, bufnr)
        lsp_zero.default_keymaps({buffer=bufnr})
    end)

    require("mason").setup({})
    require("mason-lspconfig").setup({
        ensure_installed = {
            "ruff_lsp",        -- Python
            "lua_ls",          -- Lua
            "rust_analyzer",   -- Rust
            "dockerls",        -- Docker
            "clangd",          -- C/C++
            -- "mojo-lsp-server", -- Mojo
        },
        handlers = {
            lsp_zero.default_setup,
        },
    })

    require("cmp").setup({
        sources = {
            { name = "nvim_lsp" },
            { name = "mason" },
            { name = "path" },
            { name = "buffer" },
        },
        mapping = {
            ["<Right>"] = require("cmp").mapping.complete(),
            ["<leader>c"] = require("cmp").mapping.close(),
            ["<CR>"] = require("cmp").mapping.confirm({
                behavior = require("cmp").ConfirmBehavior.Insert,
                select = true,
            }),
        },
    })
end
