{ inputs, pkgs, lib, config, ... }: let

    hypr-plugins = inputs.hyprland-plugins.packages.${pkgs.system};

in {
    imports = [
        ./keybinds.nix
        ./lock.nix
        # ./cursor.nix # managed by stylix now
    ];

    wayland.windowManager.hyprland = {
        enable = true;
        configType = "lua";
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

        extraConfig = ''
            hl.monitor({ output = "DP-3",     mode = "highres@highrr", position = "0x0",    scale = 1.5, vrr = 2 })
            hl.monitor({ output = "HDMI-A-1", mode = "highres@highrr", position = "2560x0", scale = 1.5, vrr = 2 })

            -- odd workspaces on DP-3, even on HDMI-A-1
            for i = 1, 10 do
                hl.workspace_rule({ workspace = tostring(i), monitor = (i % 2 == 1) and "DP-3" or "HDMI-A-1" })
            end

            -- "Smart gaps": a lone tiled (or fullscreen) window fills the
            -- workspace with no gaps, border or rounding.
            hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
            hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
            hl.window_rule({
                name  = "no-gaps-wtv1",
                match = { float = false, workspace = "w[tv1]" },
                border_size = 0,
                rounding    = 0,
            })
            hl.window_rule({
                name  = "no-gaps-f1",
                match = { float = false, workspace = "f[1]" },
                border_size = 0,
                rounding    = 0,
            })

            hl.on("hyprland.start", function()
                hl.exec_cmd("hyprpaper")
                hl.exec_cmd("qs")
                hl.exec_cmd("hypridle")
                -- HYPRLOCK_ON_START is only set by greetd's autologin (see lock.nix)
                hl.exec_cmd('test -n "$HYPRLOCK_ON_START" && hyprlock') -- not [ ]: a leading [ is parsed as exec rules
            end)

            hl.env("GDK_BACKEND", "wayland")
            hl.env("GDK_SCALE", "1.5")

            hl.config({
                general = {
                    gaps_in = 5,
                    gaps_out = 10,
                    border_size = 3,

                    col = {
                        active_border = { colors = { "rgba(f9cc6cee)", "rgba(fd6883ee)" }, angle = 45 },
                        inactive_border = "rgba(595959aa)",
                    },

                    layout = "master",

                    allow_tearing = false,
                },

                decoration = {
                    rounding = 17,

                    blur = {
                        enabled = true,
                        size = 3,
                        passes = 2,
                    },
                },

                input = {
                    kb_layout = "us",

                    follow_mouse = 1,
                    mouse_refocus = false,

                    accel_profile = "flat",
                    force_no_accel = true,
                    touchpad = { natural_scroll = true },

                    sensitivity = 0,
                },

                animations = { enabled = true },

                dwindle = { preserve_split = true },

                misc = {
                    force_default_wallpaper = -1,
                    -- keep rendering (and sending frame callbacks to) surfaces under the lock screen.
                    -- Otherwise hyprpaper, started alongside the autologin hyprlock, can't draw its
                    -- wallpaper until after unlock. hyprlock's background is opaque, so nothing shows through.
                    session_lock_xray = true,
                    vrr = 2, -- 2 = adaptive sync only in fullscreen apps (1 = always, causes desktop refresh swings)
                },

                xwayland = { force_zero_scaling = true },
            })

            hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

            hl.animation({ leaf = "windows",          enabled = true, speed = 5,  bezier = "myBezier" })
            hl.animation({ leaf = "windowsOut",       enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
            hl.animation({ leaf = "border",           enabled = true, speed = 10, bezier = "default" })
            hl.animation({ leaf = "borderangle",      enabled = true, speed = 8,  bezier = "default" })
            hl.animation({ leaf = "fade",             enabled = true, speed = 7,  bezier = "default" })
            hl.animation({ leaf = "workspaces",       enabled = true, speed = 6,  bezier = "default" })
            hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4,  bezier = "default", style = "slidefadevert -100%" })

            hl.window_rule({ match = { class = "wofi" }, stay_focused = true })
            hl.window_rule({ match = { class = "steap_app_291550" }, fullscreen = true })
            hl.window_rule({
                match = { class = "firefox", title = "^Picture-in-Picture$" },
                move = "(monitor_w-window_w-10) (monitor_h-window_h-10)",
                opacity = "0.5 1.0",
                persistent_size = true,
                no_initial_focus = true,
                content = "video",
                no_blur = true,
                float = true,
                pin = true,
            })
        '';
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
