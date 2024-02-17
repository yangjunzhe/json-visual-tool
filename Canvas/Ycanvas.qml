import QtQuick
import QtQuick.Controls.Windows
import "../Component"
import "../JS/Fun.js" as Funs

/*
property:
    list<QtObject> elementList
function:
    initial: onCompleted -> { elementList.push <- Funcs.loadComponent(root, elementList) } -> set rect x and y
    Key.onPressed: event -> { elementList.push <- Funcs.loadComponent(root, elementList) } -> Funs.createLineObj(root, createComponent);
*/

Item {
    id: root

    property bool autoSort: false
    property list<QtObject> elementList

    // load component function, create element and line to focus element
    function loadComponent() {
        var createComponent = Funs.loadComponent(root);    //  load component and link focus element
        Funs.createLineObj(root, createComponent);      //  create link QtObject to link focus element and new load element
    }

    anchors.fill: parent    //  anchors fill parent window

    //  component completed console debug output
    Component.onCompleted: {
        var createComponent = Funs.loadComponent(root, elementList);        //  initial load component
        createComponent.rect.x = (parent.width / 2) - (createComponent.rect.width / 2);     //  set initial load component rectangle x position
        createComponent.rect.y = (parent.height / 2) - createComponent.rect.height;     //  set initial load component rectangle y position
        elementList.push(createComponent);      //  get createComponent pointer push into elementList
        console.debug("root children:", root.children);
        console.debug("width:", root.width, "height:", root.height);
    }
    //  Key pressed event
    Keys.onPressed: event => {
        if (event.key === Qt.Key_0) {
            loadComponent();        //  run current loadComponent function
        }
    }
}
