return function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    local myTable = require("plugins.config.alpha_headers")

    vim.api.nvim_set_hl(0, "Rose", { fg = "#FF6680", bold = true })
    vim.api.nvim_set_hl(0, "Champagne", { fg = "#FFDD99", bold = true })
    vim.api.nvim_set_hl(0, "BabyBlue", { fg = "#99CCFF", bold = true })
    vim.api.nvim_set_hl(0, "Lavender", { fg = "#CC99FF", bold = true })
    vim.api.nvim_set_hl(0, "Mint", { fg = "#99FF99", bold = true })
    vim.api.nvim_set_hl(0, "Cyan", { fg = "#66FFFF", bold = true })
    vim.api.nvim_set_hl(0, "Lime", { fg = "#CCFF66", bold = true })
    vim.api.nvim_set_hl(0, "Orange", { fg = "#FF9966", bold = true })
    vim.api.nvim_set_hl(0, "Gold", { fg = "#FFCC66", bold = true })
    vim.api.nvim_set_hl(0, "Red", { fg = "#FF6666", bold = true })

    vim.api.nvim_set_hl(0, "lazyStats", { fg = "#FFC34D", italic=true })

    local choice = myTable[math.random(#myTable)]

    dashboard.section.header.val = choice.val
    dashboard.section.header.opts.hl = choice.hl

    -- vim.a n
    vim.api.nvim_create_autocmd("User", {
      group = vim.api.nvim_create_augroup("TuoGroup", { clear = false }),
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local footer_val = string.format(
          " %d/%d plugins loaded in %.3f ms",
          stats.loaded,
          stats.count,
          stats.startuptime
        )
        dashboard.section.footer.val = footer_val
        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    dashboard.section.buttons.val = {}

    local function tablelength(T)
        local count = 0
        for _ in pairs(T) do count = count + 1 end
        return count
    end

    local top_pad = vim.fn.max({1, vim.fn.floor(vim.fn.winheight(0) * 0.4 - tablelength(dashboard.section.header.val))})
    local middle_pad = vim.fn.max({1, vim.fn.floor(vim.fn.winheight(0) * 0.4 - (tablelength(dashboard.section.header.val) + top_pad))}) -- I realize this does nothing
    local bottom_pad = vim.fn.max({1, vim.fn.floor(vim.fn.winheight(0) * 0.95 - (top_pad + middle_pad + tablelength(dashboard.section.header.val) + 2 * tablelength(dashboard.section.buttons.val)))})

    dashboard.section.footer.opts.hl = "lazyStats"

    dashboard.config.layout = {
        { type = "padding", val = top_pad },
        dashboard.section.header,
        { type = "padding", val = middle_pad },
        dashboard.section.buttons,
        { type = "padding", val = bottom_pad },
        dashboard.section.footer,
    }

    alpha.setup(dashboard.opts)
end
