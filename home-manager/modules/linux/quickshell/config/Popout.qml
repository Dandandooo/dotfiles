import Quickshell
import QtQuick
import QtQuick.Shapes

// Bar background + bottom border + popout, drawn as one shape so the popout
// grows out of the bar (caelestia-dots/shell style): the border dips around it
// with concave fillets where it joins, it slides down from behind the bar on
// open and shrinks back into it on close. Switching to another item respawns
// it at the new item rather than sliding over from the old one.
Item {
    id: root

    readonly property var win: QsWindow.window
    readonly property alias hitArea: body
    readonly property bool active: Popouts.target !== null && Popouts.window === win
    readonly property real pad: 10
    readonly property real fillet: 10
    readonly property real radius: 10
    // Centerline of the 2px bottom border.
    readonly property real base: Theme.barHeight - 1

    readonly property real contentW: current.implicitWidth + pad * 2
    readonly property real contentH: current.implicitHeight + pad * 2

    // Animated geometry, set only by sync(). Writes made while `snapping`
    // bypass (and stop) the animations.
    property real popW: 0
    property real popX: 0
    property real popH: 0
    property bool snapping: false
    readonly property bool open: popH > 0.5

    Behavior on popW { enabled: !root.snapping; Anim {} }
    Behavior on popX { enabled: !root.snapping; Anim {} }
    Behavior on popH { enabled: !root.snapping; Anim {} }

    // The item the popout is currently drawn for.
    property Item shownFor: null

    function xFor(t: Item, w: real): real {
        const center = t.mapToItem(root, t.width / 2, 0).x;
        return Math.max(fillet + 4, Math.min(width - w - fillet - 4, center - w / 2));
    }

    // Brings the geometry in line with Popouts. Popouts.show() changes the
    // window, text and target one after another, so this runs once after all
    // of them (Qt.callLater coalesces) instead of reacting to each.
    function sync(): void {
        const t = active ? Popouts.target : null;

        if (!t) {
            // Close: shrink back into the bar, keeping the last text.
            shownFor = null;
            popH = 0;
            return;
        }

        current.text = Popouts.text;

        if (t !== shownFor) {
            // New item: appear at it and grow from the bar, like a fresh open.
            shownFor = t;
            snapping = true;
            popH = 0;
            popW = contentW;
            popX = xFor(t, contentW);
            snapping = false;
            popH = contentH;
        } else {
            // Same item, new text (e.g. live values): resize in place.
            popW = contentW;
            popX = xFor(t, contentW);
            popH = contentH;
        }
    }

    onActiveChanged: Qt.callLater(sync)

    Connections {
        target: Popouts
        function onTargetChanged() {
            Qt.callLater(root.sync);
        }
        function onTextChanged() {
            Qt.callLater(root.sync);
        }
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
    // Also the popout's hit area: the bar adds it to its input mask, and
    // hovering it keeps the popout open.
    Item {
        id: body
        x: root.x0
        y: root.base + 1
        width: root.popW
        height: Math.max(0, root.h - 1)
        clip: true

        HoverHandler {
            onHoveredChanged: Popouts.setHovered(hovered)
        }

        Item {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.contentW
            height: root.contentH
            opacity: root.active ? 1 : 0
            Behavior on opacity { FadeAnim {} }

            BarText {
                id: current
                anchors.centerIn: parent
                lineHeight: 1.15
            }
        }
    }
}
