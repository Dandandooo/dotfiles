import Quickshell
import QtQuick

// Port of the waybar config in ../../waybar.nix. One bar per monitor.
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
            color: Theme.base00

            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 2
                color: Theme.base0D
            }

            Workspaces {
                screen: bar.screen
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }

            ActiveWindow {
                anchors.centerIn: parent
            }

            Row {
                anchors.right: parent.right
                anchors.top: parent.top
                // Full bar height minus the bottom border; each child centers
                // itself in it (Row alone would top-align mixed heights).
                height: parent.height - 2
                spacing: 16

                Volume { anchors.verticalCenter: parent.verticalCenter }
                Separator { anchors.verticalCenter: parent.verticalCenter }
                BarText { text: ` ${SysStats.cpu}%`; anchors.verticalCenter: parent.verticalCenter }
                BarText { text: `\u{f08ae} ${SysStats.gpu}%`; anchors.verticalCenter: parent.verticalCenter }
                BarText { text: ` ${SysStats.memory}%`; anchors.verticalCenter: parent.verticalCenter }
                Power { anchors.verticalCenter: parent.verticalCenter }
                Separator { anchors.verticalCenter: parent.verticalCenter }

                BarText {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "\u{f0904}"
                    font.pixelSize: 24  // the glyph is small at the 16px text size
                    MouseArea {
                        anchors.fill: parent
                        onClicked: Quickshell.execDetached(["systemctl", "suspend"])
                    }
                }

                Clock { anchors.verticalCenter: parent.verticalCenter }
            }
        }
    }
}
