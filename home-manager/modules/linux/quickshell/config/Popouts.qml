pragma Singleton

import Quickshell
import QtQuick

// Which bar item currently owns the popout. Only one is open at a time (there's
// one pointer); each bar draws it only if `window` is that bar.
Singleton {
    id: root

    property Item target: null
    property var window: null
    property string text: ""

    function show(item: Item, win: var, txt: string): void {
        closeTimer.stop();
        window = win;
        text = txt;
        target = item;
    }

    function update(item: Item, txt: string): void {
        if (target === item)
            text = txt;
    }

    // Short grace period so moving between modules morphs the open popout to
    // the next one instead of closing and reopening it.
    function hide(item: Item): void {
        if (target === item)
            closeTimer.restart();
    }

    Timer {
        id: closeTimer
        interval: 150
        onTriggered: root.target = null
    }
}
