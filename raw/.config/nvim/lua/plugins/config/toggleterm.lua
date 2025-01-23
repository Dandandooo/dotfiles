return function()
    require("toggleterm").setup({
        shell = "$(which fish)",
    })

    -- Keybindings
    vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<cr>') 
    vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<cr>')
end
