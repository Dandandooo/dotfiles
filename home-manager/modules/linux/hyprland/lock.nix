{ pkgs, ... }:

# hyprlock's PAM service is enabled on the NixOS side (programs.hyprlock in nixos/configuration.nix).
# Colors and wallpaper come from stylix.
{
    programs.hyprlock = {
        enable = true;
        settings = {
            general = {
                hide_cursor = true;
                grace = 0;
            };
            background = {
                blur_passes = 3;
                blur_size = 6;
            };
            input-field = {
                monitor = "";
                size = "300, 50";
                position = "0, -80";
                halign = "center";
                valign = "center";
                outline_thickness = 3;
                fade_on_empty = false;
                placeholder_text = "Password...";
            };
            label = {
                monitor = "";
                text = "$TIME";
                font_size = 72;
                position = "0, 80";
                halign = "center";
                valign = "center";
            };
        };
    };

    # package = null: no systemd user service (hyprland's systemd integration is off, so its
    # target never starts). hypridle and the autologin lock are launched from hyprland.start in default.nix.
    services.hypridle = {
        enable = true;
        package = null;
        settings = {
            general = {
                lock_cmd = "pidof hyprlock || hyprlock";
                before_sleep_cmd = "loginctl lock-session";
            };
            listener = [
                { timeout = 600; on-timeout = "loginctl lock-session"; }
            ];
        };
    };
    home.packages = [ pkgs.hypridle ];

    wayland.windowManager.hyprland.extraConfig = ''
        hl.bind("SUPER + L", hl.dsp.exec_cmd("loginctl lock-session"))
    '';
}
