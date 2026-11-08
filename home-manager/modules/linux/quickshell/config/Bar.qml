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
                anchors.verticalCenter: parent.verticalCenter
                spacing: 16

                Volume {}
                Separator {}
                BarText { text: ` ${SysStats.cpu}%` }
                BarText { text: `\u{f08ae} ${SysStats.gpu}%` }
                BarText { text: ` ${SysStats.memory}%` }
                Power {}
                Separator {}

                BarText {
                    text: "\u{f0904}"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: Quickshell.execDetached(["systemctl", "suspend"])
                    }
                }

                Clock {}
            }
        }
    }
}
