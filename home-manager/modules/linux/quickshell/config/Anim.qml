import QtQuick

// Material 3 "expressive default spatial" motion, as used by caelestia-dots/shell
// for popouts: 500ms with a slight overshoot.
NumberAnimation {
    duration: 500
    easing.type: Easing.BezierSpline
    easing.bezierCurve: [0.38, 1.21, 0.22, 1, 1, 1]
}
