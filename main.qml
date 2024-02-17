import QtQuick
import QtQuick.Controls
import QtQuick.Window
import "Canvas"

Window {
    id: root

    color: "whitesmoke"
    height: Screen.height * 0.7
    title: qsTr("Hello World")
    visible: true
    width: Screen.width * 0.7

    Ycanvas {
        id: ycanvas

    }
}
