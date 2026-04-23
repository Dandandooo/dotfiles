{ pkgs, ... }:

{
    wayland.windowManager.hyprland.settings = {
        "$mainMod" = "SUPER";

        bind = [
            "$mainMod, END, exit,"

            "$mainMod, F, togglefloating,"
            "$mainMod SHIFT, F, fullscreen"
            "$mainMod, P, pseudo,"
            "$mainMod, J, togglesplit,"
            "$mainMod, K, killactive"

            "$mainMod, Q, exec, ${pkgs.kitty}/bin/kitty"
            "$mainMod ALT, Q, exec, ${pkgs.warp-terminal}/bin/warp-terminal"

            "$mainMod, B, exec, ${pkgs.firefox}/bin/firefox"
            "$mainMod ALT, B, exec, zen"

            "$mainMod, M, exec, spotify"

            "$mainMod, R, exec, ${pkgs.wofi}/bin/wofi --show drun"

            "$mainMod, G, exec, steam"
            "$mainMod, D, exec, vesktop"

            "$mainMod, left, movefocus, l"
            "$mainMod, right, movefocus, r"
            "$mainMod, up, movefocus, u"
            "$mainMod, down, movefocus, d"

            "$mainMod SHIFT, left, movewindow, l"
            "$mainMod SHIFT, right, movewindow, r"
            "$mainMod SHIFT, up, movewindow, u"
            "$mainMod SHIFT, down, movewindow, d"

            "$mainMod, 1, workspace, 1"
            "$mainMod, 2, workspace, 2"
            "$mainMod, 3, workspace, 3"
            "$mainMod, 4, workspace, 4"
            "$mainMod, 5, workspace, 5"
            "$mainMod, 6, workspace, 6"
            "$mainMod, 7, workspace, 7"
            "$mainMod, 8, workspace, 8"
            "$mainMod, 9, workspace, 9"
            "$mainMod, 0, workspace, 10"

            "$mainMod SHIFT, 1, movetoworkspace, 1"
            "$mainMod SHIFT, 2, movetoworkspace, 2"
            "$mainMod SHIFT, 3, movetoworkspace, 3"
            "$mainMod SHIFT, 4, movetoworkspace, 4"
            "$mainMod SHIFT, 5, movetoworkspace, 5"
            "$mainMod SHIFT, 6, movetoworkspace, 6"
            "$mainMod SHIFT, 7, movetoworkspace, 7"
            "$mainMod SHIFT, 8, movetoworkspace, 8"
            "$mainMod SHIFT, 9, movetoworkspace, 9"
            "$mainMod SHIFT, 0, movetoworkspace, 10"

            "$mainMod, S, togglespecialworkspace, magic"
            "$mainMod SHIFT, S, movetoworkspace, special:magic"

            "$mainMod, mouse_down, workspace, e+1"
            "$mainMod, mouse_up, workspace, e-1"

            ", xf86audiomute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ", xf86audioplay, exec, playerctl play-pause"
            ", xf86audionext, exec, playerctl next"
            ", xf86audioprev, exec, playerctl previous"
        ];

        binde = [
            ", xf86audioraisevolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ +10%"
            "$mainMod, pgup, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ +10%"
            "$mainMod, pgdown, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ -10%"
            ", xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ -10%"
        ];

        bindm = [
            "$mainMod, mouse:272, movewindow"
            "$mainMod, mouse:273, resizewindow"
        ];
    };
}
