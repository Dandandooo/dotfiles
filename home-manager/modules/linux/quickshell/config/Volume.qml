import Quickshell.Services.Pipewire
import QtQuick

// Default sink volume. Click toggles mute, scroll steps by 5%.
BarText {
    id: root
    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property bool muted: sink?.audio?.muted ?? false
    readonly property int volume: Math.round((sink?.audio?.volume ?? 0) * 100)

    readonly property var icons: ["", "", ""]
    text: muted ? ` ${volume}%`
                : `${icons[Math.min(2, Math.floor(volume / 34))]} ${volume}%`
    color: muted ? Theme.base08 : Theme.base0A

    PwObjectTracker {
        objects: [root.sink]
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.sink.audio.muted = !root.sink.audio.muted
        onWheel: wheel => {
            const step = wheel.angleDelta.y > 0 ? 0.05 : -0.05;
            root.sink.audio.volume = Math.max(0, Math.min(1, root.sink.audio.volume + step));
        }
    }
}
