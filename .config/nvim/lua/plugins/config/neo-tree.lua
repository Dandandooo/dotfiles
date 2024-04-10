return function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    
    require("neo-tree").setup()

    vim.keymap.set('n', '<leader>nt', '<cmd>Neotree toggle<cr>')
    vim.keymap.set('n', '<leader>nf', '<cmd>Neotree focus<cr>')
    vim.keymap.set('n', '<leader>ns', '<cmd>Neotree position=current toggle<cr>')
end
