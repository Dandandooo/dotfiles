import Quickshell
import Quickshell.Hyprland
import QtQuick

// Workspaces living on this bar's monitor (odd on DP-3, even on HDMI-A-1).
Row {
    id: root
    required property ShellScreen screen
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(screen)

    spacing: 6

    Repeater {
        model: Hyprland.workspaces.values
            .filter(ws => ws.id > 0 && ws.monitor === root.monitor)
            .sort((a, b) => a.id - b.id)

        Rectangle {
            required property HyprlandWorkspace modelData

            width: 26
            height: 22
            radius: 11
            color: modelData.active ? Theme.accent
                 : modelData.urgent ? Theme.urgent
                 : Theme.surface

            Text {
                anchors.centerIn: parent
                text: parent.modelData.name
                color: parent.modelData.active ? Theme.base : Theme.text
                font.family: Theme.font
                font.pixelSize: Theme.fontSize
            }

            MouseArea {
                anchors.fill: parent
                // Hyprland runs in Lua mode here, so the legacy
                // `workspace N` dispatcher (and HyprlandWorkspace.activate())
                // is rejected; send the Lua dispatcher instead.
                onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${parent.modelData.id} })`)
            }
        }
    }
}
