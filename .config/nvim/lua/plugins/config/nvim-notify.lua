return function()
    require("notify").setup({
        stages = "slide",
        timeout = 3000,
        background = "transparent",
    })
    vim.notify = require("notify")
end
