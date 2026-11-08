import Quickshell
import QtQuick
import QtQuick.Shapes

// Bar background + bottom border + popout, drawn as one shape so the popout
// grows out of the bar (caelestia-dots/shell style): the border dips around it
// with concave fillets where it joins, it slides down from behind the bar on
// open, and morphs position/size between items while the content crossfades.
Item {
    id: root

    readonly property var win: QsWindow.window
    readonly property bool active: Popouts.target !== null && Popouts.window === win
    readonly property real pad: 10
    readonly property real fillet: 10
    readonly property real radius: 10
    // Centerline of the 2px bottom border.
    readonly property real base: Theme.barHeight - 1

    property real centerX: 0
    readonly property real contentW: current.implicitWidth + pad * 2
    readonly property real contentH: current.implicitHeight + pad * 2

    // Animated geometry. x/width only animate while already open, so a fresh
    // popout appears in place and just grows; height always animates.
    property real popW: contentW
    property real popX: Math.max(fillet + 4, Math.min(width - popW - fillet - 4, centerX - popW / 2))
    property real popH: active ? contentH : 0
    readonly property bool open: popH > 0.5

    Behavior on popW { enabled: root.open; Anim {} }
    Behavior on popX { enabled: root.open; Anim {} }
    Behavior on popH { Anim {} }

    // Re-measured whenever this bar gains the popout or its target changes,
    // not only on target changes (the same item can reopen it later).
    function updateCenter(): void {
        const t = Popouts.target;
        if (root.active && t)
            root.centerX = t.mapToItem(root, t.width / 2, 0).x;
    }
    onActiveChanged: updateCenter()

    Connections {
        target: Popouts
        function onTargetChanged() {
            root.updateCenter();
        }
        function onTextChanged() {
            if (!root.active) {
                // Opening from closed: no crossfade, just show it.
                crossfade.stop();
                previous.opacity = 0;
                current.text = Popouts.text;
                current.opacity = 1;
                return;
            }
            // Morphing between items: old text fades out over the new one.
            previous.text = current.text;
            previous.opacity = 1;
            current.text = Popouts.text;
            current.opacity = 0;
            crossfade.restart();
        }
    }

    ParallelAnimation {
        id: crossfade
        FadeAnim { target: previous; property: "opacity"; to: 0 }
        FadeAnim { target: current; property: "opacity"; to: 1 }
    }

    // The overshooting curve can briefly push height below zero on close.
    readonly property real h: Math.max(0, popH)
    readonly property real f: Math.min(fillet, h / 2)
    readonly property real r: Math.min(radius, h / 2)
    readonly property real x0: popX
    readonly property real x1: popX + popW

    // From the right end of the border, around the popout, to the left end.
    readonly property string edge: {
        const b = base, f = root.f, r = root.r, h = root.h, x0 = root.x0, x1 = root.x1;
        return `L ${x1 + f} ${b} A ${f} ${f} 0 0 0 ${x1} ${b + f} `
             + `L ${x1} ${b + h - r} A ${r} ${r} 0 0 1 ${x1 - r} ${b + h} `
             + `L ${x0 + r} ${b + h} A ${r} ${r} 0 0 1 ${x0} ${b + h - r} `
             + `L ${x0} ${b + f} A ${f} ${f} 0 0 0 ${x0 - f} ${b} `
             + `L 0 ${b}`;
    }

    Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            fillColor: Theme.base00
            strokeColor: "transparent"
            PathSvg { path: `M 0 0 L ${root.width} 0 L ${root.width} ${root.base} ${root.edge} Z` }
        }

        ShapePath {
            fillColor: "transparent"
            strokeColor: Theme.base0D
            strokeWidth: 2
            PathSvg { path: `M ${root.width} ${root.base} ${root.edge}` }
        }
    }

    // Content is anchored to the popout's bottom and clipped at the bar, so it
    // slides down out from behind the bar as the popout grows.
    Item {
        x: root.x0
        y: root.base + 1
        width: root.popW
        height: Math.max(0, root.h - 1)
        clip: true

        Item {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.contentW
            height: root.contentH
            opacity: root.active ? 1 : 0
            Behavior on opacity { FadeAnim {} }

            BarText {
                id: previous
                anchors.centerIn: parent
                opacity: 0
                lineHeight: 1.15
            }

            BarText {
                id: current
                anchors.centerIn: parent
                lineHeight: 1.15
            }
        }
    }
}
