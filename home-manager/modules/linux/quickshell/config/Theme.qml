pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

// base16 colors straight from stylix (~/.config/stylix/palette.json), so the
// bar follows whatever scheme stylix.nix picks. Defaults are Catppuccin Mocha.
Singleton {
    readonly property color base00: "#" + palette.base00
    readonly property color base02: "#" + palette.base02
    readonly property color base03: "#" + palette.base03
    readonly property color base05: "#" + palette.base05
    readonly property color base08: "#" + palette.base08
    readonly property color base0A: "#" + palette.base0A
    readonly property color base0C: "#" + palette.base0C
    readonly property color base0D: "#" + palette.base0D

    // One font for every module: waybar's main font at 12pt (GTK pt = 16px).
    readonly property string font: "MonaspiceRn Nerd Font"
    readonly property int fontSize: 16
    readonly property int barHeight: 44

    FileView {
        path: Quickshell.env("HOME") + "/.config/stylix/palette.json"
        watchChanges: true
        onFileChanged: reload()

        JsonAdapter {
            id: palette
            property string base00: "1e1e2e"
            property string base02: "45475a"
            property string base03: "6c7086"
            property string base05: "cdd6f4"
            property string base08: "f38ba8"
            property string base0A: "f9e2af"
            property string base0C: "94e2d5"
            property string base0D: "89b4fa"
        }
    }
}
