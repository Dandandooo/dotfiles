{ inputs, pkgs, lib, config, ... }: let

    hypr-plugins = inputs.hyprland-plugins.packages.${pkgs.system};

in {
    imports = [
        ./keybinds.nix
        # ./cursor.nix # managed by stylix now
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

        settings = {
            monitor = [
                "DP-3,highres@highrr,0x0,1.5,vrr,1"
                "HDMI-A-1,highres@highrr,2560x0,1.5,vrr,1"
            ];

            workspace = [
                "1,monitor:DP-3"
                "3,monitor:DP-3"
                "5,monitor:DP-3"
                "7,monitor:DP-3"
                "9,monitor:DP-3"
                "2,monitor:HDMI-A-1"
                "4,monitor:HDMI-A-1"
                "6,monitor:HDMI-A-1"
                "8,monitor:HDMI-A-1"
                "10,monitor:HDMI-A-1"
            ];

            exec-once = [
                "hyprpaper"
                "waybar"
            ];

            general = {
                gaps_in = 5;
                gaps_out = 10;
                border_size = 3;

                "col.active_border" = "rgba(f9cc6cee) rgba(fd6883ee) 45deg";
                "col.inactive_border" = "rgba(595959aa)";

                layout = "master";

                allow_tearing = false;
            };

            decoration = {
                rounding = 17;

                blur = {
                    enabled = true;
                    size = 3;
                    passes = 2;
                };
            };
            
            input = {
                kb_layout = "us";

                follow_mouse = 1;
                mouse_refocus = false;
                
                accel_profile = "flat";
                force_no_accel = true;
                touchpad.natural_scroll = true;

                sensitivity = 0;
            };

            animations = {
                enabled = true;

                bezier = [
                    "myBezier, 0.05, 0.9, 0.1, 1.05"
                ];

                animation = [
                    "windows, 1, 5, myBezier"
                    "windowsOut, 1, 7, default, popin 80%"
                    "border, 1, 10, default"
                    "borderangle, 1, 8, default"
                    "fade, 1, 7, default"
                    "workspaces, 1, 6, default"
                    "specialWorkspace, 1, 4, default, slidefadevert -100%"
                ];
            };

            dwindle = {
                pseudotile = true;
                preserve_split = true;
            };

            master = {};

            misc = {
                force_default_wallpaper = -1;
                vrr = true;
                vfr = true;
            };

            xwayland = {
                force_zero_scaling = true;
            };

            env = [
                "GDK_BACKEND, wayland"
                "GDK_SCALE, 1.5"
            ];

            windowrule = [
                "match:class (wofi), stay_focused 1"
                "match:class (steap_app_291550), fullscreen 1"
                "match:class (firefox), match:title (^Picture-in-Picture$), move (monitor_w-window_w-10) (monitor_h-window_h-10)"
                "match:class (firefox), match:title (^Picture-in-Picture$), opacity 0.5 1.0"
                "match:class (firefox), match:title (^Picture-in-Picture$), persistent_size 1"
                "match:class (firefox), match:title (^Picture-in-Picture$), no_initial_focus 1"
                "match:class (firefox), match:title (^Picture-in-Picture$), content video"
                "match:class (firefox), match:title (^Picture-in-Picture$), no_blur 1"
                "match:class (firefox), match:title (^Picture-in-Picture$), float 1"
                "match:class (firefox), match:title (^Picture-in-Picture$), pin 1"
            ];
        };
    };

    services.hyprpaper = {
        enable = true;
        settings = let
            wallpaper = builtins.toString config.stylix.image;
        in {
            preload = [ wallpaper ];
            wallpaper = [ ",${wallpaper}" ];
            splash = lib.mkForce true;
        };
    };

}
