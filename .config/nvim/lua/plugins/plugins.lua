return {
    --- @Themes
    {
        "loctvl842/monokai-pro.nvim",
        config = require("plugins.config.monokai-pro"),
        lazy=false,
        priority = 1000,
    },
    { "rebelot/kanagawa.nvim" },
    { "folke/tokyonight.nvim" },
    { "catppuccin/nvim" },
    { "Mofiqul/dracula.nvim" },
    { "ellisonleao/gruvbox.nvim" },
    { "sainnhe/sonokai" },
    { "daltonmenezes/aura-theme" },
    { "EdenEast/nightfox.nvim" },
    { "Pocco81/Catppuccino.nvim" },
    { "Th3Whit3Wolf/one-nvim" },
    { "shaunsingh/moonlight.nvim" },
    { "navarasu/onedark.nvim" },
    { "nyoom-engineering/oxocarbon.nvim" },
    { "bluz71/vim-nightfly-colors" },
    { "bluz71/vim-moonfly-colors" },
    { "savq/melange-nvim" },
    { "AlexvZyl/nordic.nvim" },
    { "folke/lsp-colors.nvim" },
    { "rose-pine/neovim", name = "rose-pine" },

    --- @Miscellaneous
    {
        "andweeb/presence.nvim",
        config = {
            neovim_image_text = "Why do I do this to myself?",
            auto_update=true,
            show_time=true
        },
    },

    {
        "rcarriga/nvim-notify",
        config = require("plugins.config.nvim-notify"),
        lazy=false,
    },

    {
        "folke/todo-comments.nvim",
        config = function() require("todo-comments").setup{} end,
    },
    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    }, -- Color Viewing

    {
        "goolord/alpha-nvim",
        config = require("plugins.config.alpha"),
    },

    {
        "stevearc/dressing.nvim",
        config = function()
            require("dressing").setup()
        end,
    }, -- fancy selection menu

    -- { "stsewd/spotify.nvim", },
    {
        "famiu/feline.nvim",
        config = require("plugins.config.feline")
    },

    --- @Productivity
    {
        "folke/twilight.nvim",
        config = require("plugins.config.twilight"),
    },

    --- @Shortcuts
    {
        "folke/which-key.nvim",
        config = require("plugins.config.which-key"),
        lazy=false,
    },

    {
        "numToStr/Comment.nvim",
        config = require("plugins.config.comment"),
    },

    --- @Syntax
    {
        "nvim-treesitter/nvim-treesitter",
        config = require("plugins.config.treesitter"),
        build=":TSUpdate",
    },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    {
        "kevinhwang91/nvim-ufo",
        dependencies={"kevinhwang91/promise-async"},
    },
    { "HiPhish/rainbow-delimiters.nvim", },
    { "folke/paint.nvim" }, -- comment colorizer
    { "ovikrai/mojo-syntax" }, -- mojo syntax highlighting

    --- @LSP
    { "github/copilot.vim", },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch="v3.x",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = require("plugins.config.lsp-zero"),
    },
    {
        "aznhe21/actions-preview.nvim",
        config = require("plugins.config.actions-preview"),
    },
    {
        "folke/neodev.nvim",
        config = require("plugins.config.neodev"),
    },
    {
        "NMAC427/guess-indent.nvim",
        config = function()
            require("guess-indent").setup()
        end,
    },

    --- @Terminal Utilities
    {
        "akinsho/nvim-toggleterm.lua",
        config = require("plugins.config.toggleterm"),
    },

    --- @File Utility
    {
        "nvim-telescope/telescope.nvim",
        config=require("plugins.config.telescope")
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        config=require("plugins.config.neo-tree"),
        dependencies={"MunifTanjim/nui.nvim"},
    },
    {
        'esensar/nvim-dev-container',
        config=function()
            require("devcontainer").setup{}
        end,
    },
    {
        "stevearc/aerial.nvim", -- program structure
        config = require("plugins.config.aerial"),
    },
    {
        "thePrimeagen/harpoon",
        config = require("plugins.config.harpoon"),
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    --- @Verion Control
    {
        "lewis6991/gitsigns.nvim",
        config=function() require("gitsigns").setup() end,
    },
    {
        "mbbill/undotree",
        config=require("plugins.config.undotree"),
    },

    --- @Global Dependencies
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-tree/nvim-web-devicons" },
}
