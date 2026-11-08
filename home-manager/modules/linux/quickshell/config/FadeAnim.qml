import QtQuick

// Material 3 "expressive default effects" (opacity etc.): 200ms, no overshoot.
NumberAnimation {
    duration: 200
    easing.type: Easing.BezierSpline
    easing.bezierCurve: [0.34, 0.8, 0.34, 1, 1, 1]
}
