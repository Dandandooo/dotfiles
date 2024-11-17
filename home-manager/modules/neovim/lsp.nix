{ config, pkgs, ... }:

{
    programs.nixvim.plugins = {
        lsp = {
            enable = true;
            
            servers = {
                dockerls.enable = true; # docker
                clangd.enable = true; # c/c++
                rust_analyzer = {
                    enable = true;
                    installCargo = true;
                    installRustc = true;
                };
                lua_ls.enable = true; # lua
                gleam.enable = true; # gleam

                hls = {
                    enable = true; # haskell
                    installGhc = true;
                };
                hyprls.enable = true; # hypr
                java_language_server.enable = true; # java
                mojo = {
                    enable = true; # mojo
                    package = null;
                };
                ruff.enable = true; # python
                ruff_lsp.enable = true; # python
                zls.enable = true; # zig
                
                # ts_ls.enable = true; # typescript
                cssls.enable = true; # css
                html.enable = true; # html

                bashls.enable = true; # bash
                nushell.enable = true; # nushell
            };

        };

        # Github Copilot

        cmp = {
            # enable = true;
            autoEnableSources = true;
        };
        # cmp-nvim-lsp.enable = true;
        # copilot-cmp.enable = true;
        
        # copilot-vim.enable = true;
        copilot-lua.enable = true;


    };

}
