import QtQuick
import QtQuick.Shapes
import "../Component"
import "../JS/Fun.js" as Funs

Element {
    property double angle: Funs.vectorAngle(this)
    property list<QtObject> connObj     //  connect Element object list
    property bool connVisible: true
    property QtObject preObj: null      //  pre main Element object

    function reVisible(temp) {
        for (var i = 0; i < connObj.length; i++) {
            connObj[i].visible = temp;
        }
    }

    abbreviate.visible: (connObj.length > 0) ? true : false

    // rectDrag.enabled: true      //  set drag enable

    abbreviateTap.onTapped: (eventPoint, button) => {
        if (connVisible)
            connVisible = false;
        else
            connVisible = true;
        reVisible(connVisible);
    }
    onVisibleChanged: reVisible(visible)

    Connection {
        endX: (parent.preObj === null) ? 0 : (angle > 45 && angle <= 135) ? parent.connectDown.centerX : (angle > 135 && angle <= 225) ? parent.connectRight.centerX : (angle > 225 && angle <= 315) ? parent.connectUp.centerX : (angle > 315 || angle <= 45) ? parent.connectLeft.centerX : 0
        endY: (parent.preObj === null) ? 0 : (angle > 45 && angle <= 135) ? parent.connectDown.centerY : (angle > 135 && angle <= 225) ? parent.connectRight.centerY : (angle > 225 && angle <= 315) ? parent.connectUp.centerY : (angle > 315 || angle <= 45) ? parent.connectLeft.centerY : 0
        startX: (parent.preObj === null) ? 0 : (angle > 45 && angle <= 135) ? parent.preObj.connectUp.centerX : (angle > 135 && angle <= 225) ? parent.preObj.connectLeft.centerX : (angle > 225 && angle <= 315) ? parent.preObj.connectDown.centerX : (angle > 315 || angle <= 45) ? parent.preObj.connectRight.centerX : 0
        startY: (parent.preObj === null) ? 0 : (angle > 45 && angle <= 135) ? parent.preObj.connectUp.centerY : (angle > 135 && angle <= 225) ? parent.preObj.connectLeft.centerY : (angle > 225 && angle <= 315) ? parent.preObj.connectDown.centerY : (angle > 315 || angle <= 45) ? parent.preObj.connectRight.centerY : 0
        visible: (preObj === null) ? false : true
    }
}
