{ inputs, config, lib, pkgs, ... }: let

    hypr-plugins = inputs.hyprland-plugins-packages.${pkgs.stdenv.hostPlatform.system};

in {

    wayland.windowManager.hyprland = {
        plugins = [
            hypr-plugins.hy3
            hypr-plugins.hyprtrails
            hypr-plugins."borders++"
        ];
    };

}
