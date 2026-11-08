import Quickshell
import QtQuick

Text {
    text: Qt.formatDateTime(clock.date, "ddd d MMM  hh:mm")
    color: Theme.text
    font.family: Theme.font
    font.pixelSize: Theme.fontSize

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
