
/*
caluclate Rectangle object to pre Rectangle object angle
rect & rect.preObj -> centerX & centerY -> sin & cos -> angle
rect.preObj.begin -> right(1)-> [INT_MIN, 45] && (315, INT_MAX]; up(2)-> (45, 135] ; left(3)-> (135, 225]; down(4)-> (225,315]
rect.obj.end -> end is reverse x axis, angle way is clockwise
*/
function vectorAngle(obj) {
    if (obj.preObj !== null) {
        let vectorX = obj.preObj.rect.rectCenterX - obj.rect.rectCenterX    //  vector x
        let vectorY = obj.preObj.rect.rectCenterY - obj.rect.rectCenterY    //  vector y
        let vectorR = Math.sqrt(vectorX * vectorX + vectorY * vectorY)    //  vector r
        let acos = Math.acos(vectorX / vectorR) * 180 / Math.PI    //  arccos
        let asin = Math.asin(vectorY / vectorR) * 180 / Math.PI    //  arcsin
        let angle = ((acos * asin) < 0) ? 180 + acos : 180 - acos    //  get standard axis, angle
        return angle
    }
    else {
        return 0
    }
    /*
    //  angle begin: right(1)-> [INT_MIN, 45] && (315, INT_MAX]; up(2)-> (45, 135] ; left(3)-> (135, 225]; down(4)-> (225,315]
    var beginX = (angle > 45 && angle <= 135) ? obj.preObj.connectUp.centerX : (angle > 135 && angle <= 225) ? obj.preObj.connectLeft.centerX : (angle > 225 && angle <= 315) ? obj.preObj.connectDown.centerX : (angle > 315 || angle <= 45) ? obj.preObj.connectRight.centerX : 0
    var beginY = (angle > 45 && angle <= 135) ? obj.preObj.connectUp.centerY : (angle > 135 && angle <= 225) ? obj.preObj.connectLeft.centerY : (angle > 225 && angle <= 315) ? obj.preObj.connectDown.centerY : (angle > 315 || angle <= 45) ? obj.preObj.connectRight.centerY : 0
    //  angle end is reverse x axis, angle way is clockwise
    var endX = (angle > 45 && angle <= 135) ? obj.connectDown.centerX : (angle > 135 && angle <= 225) ? obj.connectRight.centerX : (angle > 225 && angle <= 315) ? obj.connectUp.centerX : (angle > 315 || angle <= 45) ? obj.connectLeft.centerX : 0
    var endY = (angle > 45 && angle <= 135) ? obj.connectDown.centerY : (angle > 135 && angle <= 225) ? obj.connectRight.centerY : (angle > 225 && angle <= 315) ? obj.connectUp.centerY : (angle > 315 || angle <= 45) ? obj.connectLeft.centerY : 0
    var anyWay = (angle > 45 && angle <= 135) ? 1 : (angle > 135 && angle <= 225) ? 0 : (angle > 225 && angle <= 315) ? 1 : (angle > 315 || angle <= 45) ? 0 : 0
    return [beginX, beginY, endX, endY, anyWay] //  return object connect Rectangle begin and end position
    */
}


/*
dynamic create component <-- ../Component/Element.qml
initial create new binding property and link rect dragHandler function. binding new create component to root object

Element
property:
    list<QtObject> connObj
    list<QtObject> conn
    QtObject preObj: null
    QtObject preConn: null

function:
    DragHandler rectDrag.onTranslationChanged

*/
function createElement(rootObj) {
    var component = Qt.createQmlObject(`

import QtQuick
import "../Canvas"

ACreateElement {
}
                                       `, rootObj, "myDynamicSnippet")
    return component
}


/*
if check focus Element and none Element, create Element. push new Element pointer to elementlist.
*/
function loadComponent(rootObj) {
    var obj
    var component
    //  ergodic root object Element focus states, get focus object.
    for (var i = 0; i < rootObj.elementList.length; i++) {
        if (rootObj.elementList[i].rect.focus === true) {
            obj = rootObj.elementList[i]
        }
    }
    //  if none Element in root, create new Element.
    if (obj === undefined) {
        component = createElement(rootObj)
        rootObj.elementList.push(component)
        component.rectDrag.enabled = rootObj.autoSort
        return component
    }
    //  if check focus Element, create new Element.
    if (obj.rect.focus === true) {
        if (obj.connObj.length > 0) {
            for (var j = 0; j < obj.connObj.length; j++) {
                obj.connObj[j].visible = true;
            }
        }

        component = createElement(rootObj)
        component.rectDrag.enabled = rootObj.autoSort
        component.rect.x = obj.rect.x + obj.rect.width * 2 //  add element x position
        component.rect.y = obj.rect.y + obj.rect.height * 1.5 * obj.connObj.length //  add element y position
        obj.connObj.push(component) //  connect Element object list push new create component
        component.preObj = obj //  set new create component -> pre maine Element object
        rootObj.elementList.push(component) //  get createComponent pointer push into elementList
        console.debug("create object component: ", component, " pre component: ", component.preObj)
        return component
    }
}
