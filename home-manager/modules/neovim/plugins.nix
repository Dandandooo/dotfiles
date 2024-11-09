{ inputs, config, pkgs, nix-colors, ... }:

{
    programs.nixvim.plugins = {
        # Syntax
        treesitter = {
            enable = true;
            settings = {
                indent.enable = true;
                ensure_installed = [
                    "hyprlang"
                    "python"
                    "rust"
                    "fish"
                    "lua"
                    "nix"
                    "zig"
                    "cpp"
                    "c"
                ];
                highlight.enable = true;
                auto_install = true;
                sync_install = false;
            };
            luaConfig = {
                post = ''
                    vim.filetype.add({
                        pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
                    })
                '';
            };
        };
        rainbow-delimiters.enable = true;

        # LSP is in another file

        # File Management
        neo-tree = {
            enable = true;
            autoCleanAfterSessionRestore = true;
        };
        web-devicons.enable = true;

        telescope = {
            enable = true;
        };


        # UI
        dressing.enable = true;
        transparent.enable = true;
        todo-comments.enable = true;
        nvim-colorizer.enable = true;


        # Editing
        guess-indent.enable = true;
        comment = {
            enable = true;
            settings = {
                toggler = {
                    line = "<D-/>";
                    block = "<leader>cb";
                };
            };
        };

        # GIT
        gitsigns.enable = true;
        
        # Fun
        presence-nvim = {
            enable = true;
            neovimImageText = "Why do I do this to myself?";
            pluginManagerText = "Wasting time ricing";
        };

    };
}
