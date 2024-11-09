{ config, pkgs, nix-colors, ... }:

{
    programs.nixvim.colorscheme = "rose-pine";

    programs.nixvim.colorschemes = {
        rose-pine = {
            enable = true;
            settings = {
                variant = "auto";
                dark_variant = "moon";

                styles = {
                    transparency = true;
                    italic = true;
                    bold = true;
                };
            };
        };

        kanagawa = {
            enable = true;
        };

        melange = {
            enable = true;
        };

        everforest = {
            enable = true;
            settings = {
                variant = "hard";
            };
        };
    };
}
