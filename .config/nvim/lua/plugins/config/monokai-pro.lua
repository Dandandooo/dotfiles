return function()
    require("monokai-pro").setup({
        devicons = true,
        transparent_background = false,
        -- filter="ristretto",
    })
    vim.cmd([[colorscheme monokai-pro-ristretto]])
end
