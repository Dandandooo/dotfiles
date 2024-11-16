{ config, pkgs, nix-colors, ... }:

{
    programs.nixvim.colorscheme = "monokai-pro-ristretto";

    programs.nixvim.extraPlugins = [
        { plugin = pkgs.vimPlugins.monokai-pro-nvim; }
        # { plugin = pkgs.vimPlugins.styler-nvim; }
    ];

    # programs.nixvim.extraConfigLua = ''
        # require("styler").setup({
	        # themes = {
                # nix = "rose-pine-main";
            # },
        # })
     # '';

    programs.nixvim.colorschemes = {
        rose-pine = {
            enable = true;
            settings = {
                variant = "auto";
                dark_variant = "main";

                styles = {
                    transparency = false;
                    italic = true;
                    bold = true;
                };
            };
        };

        everforest = {
            enable = true;
            settings = {
                background = "hard";
            };
        };

        tokyonight.enable = true;
        catppuccin.enable = true;
        nightfox.enable = true;
        kanagawa.enable = true;
        melange.enable = true;
    };
}
