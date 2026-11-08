pragma Singleton

import Quickshell
import QtQuick

// Catppuccin Mocha, matching the base16 scheme stylix uses (stylix.nix).
Singleton {
    readonly property color base: "#1e1e2e"
    readonly property color surface: "#313244"
    readonly property color overlay: "#6c7086"
    readonly property color text: "#cdd6f4"
    readonly property color accent: "#f9e2af"
    readonly property color urgent: "#f38ba8"

    readonly property string font: "CaskaydiaCove Nerd Font"
    readonly property int fontSize: 13
    readonly property int barHeight: 32
}
