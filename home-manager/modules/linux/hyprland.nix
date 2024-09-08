{ inputs, pkgs, ... }: let

    hypr-plugins = inputs.hyprland-plugins.packages.${pkgs.system};

in {
    wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false;
        plugins = [
            # hypr-plugins.hy3
            # hypr-plugins.hyprtrails
            hypr-plugins.borders-plus-plus
        ];

        settings = {
            "plugin:borders-plus-plus" = {
                add_borders = 1;
                "col.border1" = "0x000000";
                "col.border2" = "0x000000";
                border-size_1 = 2;
                border-size_2 = 2;
                natural_rounding = "yes";
            };

        };
    };

}
