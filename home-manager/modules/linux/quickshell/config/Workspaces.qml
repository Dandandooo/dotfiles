import Quickshell
import Quickshell.Hyprland
import QtQuick

// Persistent workspaces per monitor, like waybar's persistent-workspaces:
// odd on DP-3, even on HDMI-A-1.
Row {
    id: root
    required property ShellScreen screen
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(screen)
    readonly property int parity: screen.name === "HDMI-A-1" ? 0 : 1

    spacing: 4
    leftPadding: 4

    Repeater {
        model: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].filter(i => i % 2 === root.parity)

        Rectangle {
            id: button
            required property int modelData
            readonly property HyprlandWorkspace ws:
                Hyprland.workspaces.values.find(w => w.id === modelData) ?? null
            readonly property bool active: Hyprland.focusedWorkspace?.id === modelData

            width: Math.max(36, label.implicitWidth + 16)
            height: 32
            radius: 8
            color: "transparent"
            border.width: 2
            border.color: active ? Theme.base0D : "transparent"

            BarText {
                id: label
                anchors.centerIn: parent
                text: button.modelData
                color: button.ws?.urgent ? Theme.base08
                     : button.active ? Theme.base0C
                     : Theme.base0A
            }

            MouseArea {
                anchors.fill: parent
                // Hyprland runs in Lua mode here, so the legacy
                // `workspace N` dispatcher (and HyprlandWorkspace.activate())
                // is rejected; send the Lua dispatcher instead.
                onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${button.modelData} })`)
            }
        }
    }
}
