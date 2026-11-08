import Quickshell
import QtQuick

// One bar per monitor. Variants creates a PanelWindow for each screen and
// injects it as modelData.
Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }
            implicitHeight: Theme.barHeight
            color: Theme.base

            Workspaces {
                screen: bar.screen
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
            }

            Clock {
                anchors.centerIn: parent
            }
        }
    }
}
