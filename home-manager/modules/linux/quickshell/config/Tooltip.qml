import Quickshell
import QtQuick

// Hover tooltip centered under `target`, styled like the workspace buttons.
PopupWindow {
    id: root
    required property Item target
    property bool shown: false
    property string text

    // Anchor to the target plus a gap below it, then grow downward from the
    // middle of that rect's bottom edge, which centers the popup.
    anchor.item: target
    anchor.rect.width: target.width
    anchor.rect.height: target.height + 10
    anchor.edges: Edges.Bottom
    anchor.gravity: Edges.Bottom

    visible: shown && text !== ""
    color: "transparent"
    implicitWidth: label.implicitWidth + 24
    implicitHeight: label.implicitHeight + 14

    Rectangle {
        anchors.fill: parent
        color: Theme.base00
        border.color: Theme.base0D
        border.width: 2
        radius: 8

        BarText {
            id: label
            anchors.centerIn: parent
            text: root.text
            lineHeight: 1.15
        }
    }
}
