import QtQuick

// Total CPU (RAPL) + GPU power draw, with a per-device breakdown on hover.
BarText {
    id: root
    text: `\u{f140b} ${(SysStats.cpuWatts + SysStats.gpuWatts).toFixed(1)}W`

    MouseArea {
        id: hover
        anchors.fill: parent
        hoverEnabled: true
    }

    Tooltip {
        target: root
        shown: hover.containsMouse
        text: `CPU ${SysStats.cpuWatts.toFixed(1)}W\nGPU ${SysStats.gpuWatts.toFixed(1)}W`
    }
}
