import QtQuick
import QtQuick.Controls.Windows
import "../JS/Fun.js" as Funs

/*
property:
    alias connectUp <- connectUp
    alias connectDown <- connectDown
    alias connectLeft <- connectLeft
    alias connectRight <- connectRight
    alias rect <- rect
    alias text <- rectText.text
    int connectSize : 4

element:
    Rectangle rect:
    property:
        double rectCenterX
        double rectCenterY
    element:
        Text rectText
        HoverHandler rectHover
        TapHandler rectTap: onTapped: (eventPoint, button)
        DragHandler rectDrag

    Rectangle connectUp / connectRight / connectDown / connectLeft:
    property:
        double rectCenterX
        double rectCenterY
*/
Item {
    id: root

    property alias abbreviate: abbreviate
    property alias abbreviateTap: abbreviateTap
    property alias connectDown: connectDown //  alias link rectangle connectDown
    property bool connectEnable: false
    property alias connectLeft: connectLeft //  alias link rectangle connectLeft
    property alias connectRight: connectRight //  alias link rectangle connectRight
    property int connectSize: 4 //  rectangle connect size
    property alias connectUp: connectUp //  alias link rectangle connectUp
    property alias itemX: rect.x
    property alias itemY: rect.y
    property alias rect: rect //  alias link rectangle rect
    property alias rectDrag: rectDrag //  drag enable binding rect->DragHandler
    property alias text: rectText.text //  text name binding rect->Text

    anchors.fill: parent
    scale: 1

    Rectangle {
        id: rect

        property double rectCenterX: rect.x + rect.width / 2 //  rectangel rect center x
        property double rectCenterY: rect.y + rect.height / 2 //  rectangel rect center y

        // color: rectHover.hovered ? "#87CEFF" : "#87CEEC"    // mouse hovered
        color: "#ffffff"
        focus: false
        height: root.height * 0.07
        radius: 3
        // anchors.fill: parent // can't used , it make darg handler fail
        width: root.width * 0.1

        border {
            color: rectHover.hovered ? "lavender" : "slategrey" // mouse clicked change item focus
            width: 1
        }
        //  rectangel text
        Text {
            id: rectText

        }
        //  mouse hovered handler check mosue hoverd to change color
        HoverHandler {
            id: rectHover

            acceptedPointerTypes: PointerDevice.AllPointerTypes
            cursorShape: Qt.PointingHandCursor
        }
        //  mouse clicked handler
        TapHandler {
            id: rectTap

            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onTapped: (eventPoint, button) => {
                //  mouse left clicked change element focus
                if (button === Qt.LeftButton)
                    parent.focus = true;
                console.debug("tapped", eventPoint.device.name, "button", button, "@", eventPoint.scenePosition);
            }
        }
        //  mouse drag handler
        DragHandler {
            id: rectDrag

            enabled: false
        }
    }
    Rectangle {
        id: abbreviate

        property double baisSize: rect.height * 0.2

        height: baisSize
        radius: baisSize / 2
        width: baisSize
        x: rect.x + rect.width - baisSize
        y: rect.y + rect.height / 2 - baisSize / 2

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "+"
        }
        border {
            color: "lavender"
            width: 0.5
        }
        TapHandler {
            id: abbreviateTap

            acceptedButtons: Qt.LeftButton
        }
    }
    //  rectangel connectUp
    Rectangle {
        id: connectUp

        property double centerX: x + width / 2 //  rectangel connectUp center x
        property double centerY: y + height / 2 //  rectangel connectUp center y

        color: "black"
        focus: false
        height: root.connectSize
        visible: root.connectEnable ? (rectHover.hovered | rect.focus) ? true : false : false
        width: root.connectSize
        x: rect.x + rect.width / 2
        y: rect.y + rect.height * 0 - root.connectSize / 2
    }
    //  rectangel connectRight
    Rectangle {
        id: connectRight

        property double centerX: x + width / 2 //  rectangel connectRight center x
        property double centerY: y + height / 2 //  rectangel connectRight center y

        color: "black"
        focus: false
        height: root.connectSize
        visible: root.connectEnable ? (rectHover.hovered | rect.focus) ? true : false : false
        width: root.connectSize
        x: rect.x + rect.width - root.connectSize / 2
        y: rect.y + rect.height / 2
    }
    //  rectangel connectDown
    Rectangle {
        id: connectDown

        property double centerX: x + width / 2 //  rectangel connectDown center x
        property double centerY: y + height / 2 //  rectangel connectDown center y

        color: "black"
        focus: false
        height: root.connectSize
        visible: root.connectEnable ? (rectHover.hovered | rect.focus) ? true : false : false
        width: root.connectSize
        x: rect.x + rect.width / 2
        y: rect.y + rect.height - root.connectSize / 2
    }
    //  rectangel connectLeft
    Rectangle {
        id: connectLeft

        property double centerX: x + width / 2 //  rectangel connectLeft center x
        property double centerY: y + height / 2 //  rectangel connectLeft center y

        color: "black"
        focus: false
        height: root.connectSize
        visible: root.connectEnable ? (rectHover.hovered | rect.focus) ? true : false : false
        width: root.connectSize
        x: rect.x + rect.width * 0 - root.connectSize / 2
        y: rect.y + rect.height / 2
    }
}
