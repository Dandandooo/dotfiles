import Quickshell
import QtQuick

// 12h clock in a left-rounded box flush with the right edge; click for 24h.
Item {
    id: root
    property bool alt: false

    implicitWidth: label.implicitWidth + 8 + 6
    implicitHeight: 32

    // Rounded only on the left: the right side runs off past the bar edge.
    Rectangle {
        anchors.fill: parent
        anchors.rightMargin: -radius
        radius: 8
        color: "transparent"
        border.color: Theme.base0D
        border.width: 2
    }

    BarText {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        x: 8
        text: Qt.formatDateTime(clock.date, root.alt ? "HH:mm" : "hh:mm AP")
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.alt = !root.alt
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
