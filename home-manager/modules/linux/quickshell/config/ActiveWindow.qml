import Quickshell.Wayland

// Class of the focused window (waybar's hyprland/window with format {class}).
BarText {
    text: ToplevelManager.activeToplevel?.appId ?? ""
}
