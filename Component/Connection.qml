import QtQuick
import QtQuick.Shapes

Shape {
    id: shape

    property real endX: 0
    property real endY: 0
    property int lineType: 1
    property alias startX: shapeQuad.startX
    property alias startY: shapeQuad.startY

    anchors.fill: parent

    ShapePath {
        id: shapeLine

        startX: shape.startX
        startY: shape.startY
        strokeColor: "darkslategray"
        strokeWidth: 2

        PathLine {
            x: (shape.lineType === 0) ? shape.endX : shape.startX
            y: (shape.lineType === 0) ? shape.endY : shape.startY
        }
    }
    ShapePath {
        id: shapeQuad

        property real endX: 0
        property real endY: 0

        startX: 0
        startY: 0
        strokeColor: "darkslategray"
        strokeWidth: 1

        PathCubic {
            control1X: (shape.lineType === 1) ? (startX + endX) / 2 : startX
            control1Y: (shape.lineType === 1) ? startY : startY
            control2X: (shape.lineType === 1) ? (startX + endX) / 2 : startX
            control2Y: (shape.lineType === 1) ? endY : startY
            x: (shape.lineType === 1) ? endX : startX
            y: (shape.lineType === 1) ? endY : startY
        }
    }
}
