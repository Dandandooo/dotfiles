{ inputs, pkgs, ... }: let

    hypr-plugins = inputs.hyprland-plugins.packages.${pkgs.system};

in {

    imports = [
        ./cursor.nix
    ];

    wayland.windowManager.hyprland = {
        enable = true;
        systemd = {
            enable = false;
            extraCommands = lib.mkBefore [
                "systemctl --user stop graphical-session.target"
                "systemctl --user start hyprland-session.target"
            ];
        };
        plugins = [
            # hypr-plugins.hy3
            # hypr-plugins.hyprtrails
            # hypr-plugins.borders-plus-plus
        ];

        settings = let
            terminal = "${pkgs.kitty}/bin/kitty";
            alt-terminal = "${pkgs.warp-terminal}/bin/warp-terminal";

            browser = "zen";
            alt-browser = let
                pkg = config.programs.firefox.package;
                name = "firefox-nightly";
            in "${pkg}/bin/${name}";

            app-search = "${pkgs.wofi}/bin/wofi";

            brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
            pamixer = "${pkgs.pamixer}/bin/pamixer";
        in {
            exec-once = [
                "hyprpaper"
                "openrgb --start-minimized"
            ];

            general = {
                gaps_in = 5;
                gaps_out = 10;
                border_size = 3;

                "col.active_border" = "rgba(f9cc6cee) rgba(fd6883ee) 45deg";
                "col.inactive_border" = "rgba(595959aa)";

                layout = "dwindle";

                allow_tearing = false;
            };

            decoration = {
                rounding = 17;

                blur = {
                    enabled = false;
                    size = 3;
                    passes = 2;
                    new_optimizations = true;
                };

                shadow.enabled = true;
            };
            
            input = {
                kb_variant = "us";

                follow_mouse = true;
                
                accel_profile = "flat";
                force_no_accel = true;
                natural_scroll = false;
                touchpad.natural_scroll = true;

                sensitivity = 0.0;
            };

            animations = {
                enabled = true;

                bezier = [
                    "glide, 0.05, 0.9, 0.1, 1.05"
                ];

                animation = [
                    "windows, 1, 5, glide"
                    "windowsOut, 1, 7, default, popin 80%"
                    "border, 1, 10, default"
                    "borderangle, 1, 8, default"
                    "fade, 1, 7, default"
                    "workspaces, 1, 6, default"
                ];
            };

            dwindle = {
                pseudotile = true;
                preserve_split = true;
            };

            gestures = {
                workspace_swipe = true;
            };

            xwayland = {
                force_zero_scaling = false;
            };

            env = [
                "GDK_BACKEND, wayland"
            ];

            bind = [
                "SUPER, Q, exec, ${terminal}"
                "SUPER ALT, Q, exec, ${alt-terminal}"
                "SUPER, B, exec, ${browser}"
                "SUPER ALT, B, exec, ${alt-browser}"
                "SUPER, D, exec, discord"
                "SUPER, G, exec, steam"
            ];

            binde = [
                ",XF86MonBrightnessUp,exec,${brightnessctl} s 5%+"
                ",XF86MonBrightnessDown,exec,${brightnessctl} s 5%-"
                ",XF86AudioRaiseVolume,exec,${pamixer} -i 5"
                ",XF86AudioLowerVolume,exec,${pamixer} -d 5"
                ",XF86AudioMute,exec,${pamixer} -t"
            ];

            # "plugins:hyprtrails" = {
            #     enable = true;
            # };
        };
    };

    services.hyprpaper = {
        enable = true;
        settings = let
            wallpaper = builtins.toString config.stylix.image;
        in {
            preload = [ wallpaper ];
            wallpaper = [ ",${wallpaper}" ];
            splash = true;
        };
    };

}
