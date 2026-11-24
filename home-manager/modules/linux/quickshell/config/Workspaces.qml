import Quickshell
import Quickshell.Hyprland
import QtQuick

// Persistent workspaces per monitor, like waybar's persistent-workspaces.
// Mirrors the Hyprland rule in hyprland/monitors.nix, based only on how many
// screens are connected (re-evaluated on hotplug, Quickshell.screens is live):
//   1 screen  -> 1-10 on it
//   2+ screens -> odd on the first, even on the second (sorted by output name)
Row {
    id: root
    required property ShellScreen screen
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(screen)
    readonly property var order: Quickshell.screens.map(s => s.name).sort()
    readonly property int index: order.indexOf(screen.name)

    function shows(i) {
        if (order.length < 2) return true;
        if (index === 0) return i % 2 === 1;
        if (index === 1) return i % 2 === 0;
        return false;
    }

    spacing: 4
    leftPadding: 4

    Repeater {
        model: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].filter(i => root.shows(i))

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
