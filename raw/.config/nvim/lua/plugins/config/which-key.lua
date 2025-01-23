return function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500

    vim.api.nvim_set_keymap("n", "<leader>?", "<cmd>WhichKey<cr>", { noremap = true, silent = true })
end
