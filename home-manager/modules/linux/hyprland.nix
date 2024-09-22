{ inputs, pkgs, ... }: let

    hypr-plugins = inputs.hyprland-plugins.packages.${pkgs.system};

in {
    wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false;
        plugins = [
            # hypr-plugins.hy3
            # hypr-plugins.hyprtrails
            # hypr-plugins.borders-plus-plus
        ];

        settings = {
            "plugins:hyprtrails" = {
                enable = true;

            };

        };
    };

}
