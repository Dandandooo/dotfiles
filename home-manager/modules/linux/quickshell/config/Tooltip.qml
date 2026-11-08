import Quickshell
import QtQuick

// Declares a popout for `target`; the bar's Popout draws and animates it.
Item {
    required property Item target
    property bool shown: false
    property string text

    onShownChanged: shown ? Popouts.show(target, QsWindow.window, text) : Popouts.hide(target)
    onTextChanged: Popouts.update(target, text)
}
