import QtQuick
import QtQuick.Controls.Windows

/*
property:
    list<double> position: [0, 0, 0, 0]
    signal draw

function:
    onDraw -> canvas.requesPaint

element:
    Canvas canvas:
    function:
        onPaint
*/
Item {
    id: root

    property int anyWay: 0 //  0: cross direction; 1: direction
    property bool anyWayEnable: false
    property alias itemX: canvas.x
    property alias itemY: canvas.y
    property int lineType: 0
    property list<double> position: [0, 0, 0, 0] // line position form begin to end

    signal draw

    //  line draw signal
    anchors.fill: parent

    //  draw signal connect function
    onDraw: {
        // console.debug("canvas beginX is: ", root.position[0], " beginY is: ", root.position[1], " endX is: ", root.position[2], "endY is: ", root.position[3]);
        canvas.requestPaint(); //  line repainting
    }

    // Canvas class
    Canvas {
        id: canvas

        anchors.fill: parent

        //  painting function
        onPaint: {
            var ctx = getContext("2d");
            //  2d context
            ctx.lineWidth = 1.5; //  line width
            ctx.strokeStyle = "darkslategray"; // line color
            ctx.beginPath();
            ctx.clearRect(0, 0, canvas.width, canvas.height); //  clear canvas
            ctx.stroke();
            switch (lineType) {
            case 0:
                {
                    ctx.beginPath();
                    ctx.moveTo(root.position[0], root.position[1]); //start point
                    ctx.lineTo(root.position[2], root.position[3]); // end point
                    break;
                }
            case 1:
                {
                    ctx.beginPath();
                    ctx.moveTo(root.position[0], root.position[1]);
                    if (anyWay === 1 && anyWayEnable === true)
                        ctx.bezierCurveTo(root.position[0], (root.position[3] - root.position[1]) / 2 + root.position[1], root.position[2], (root.position[3] - root.position[1]) / 2 + root.position[1], root.position[2], root.position[3]);
                    else
                        ctx.bezierCurveTo((root.position[2] - root.position[0]) / 2 + root.position[0], root.position[1], (root.position[2] - root.position[0]) / 2 + root.position[0], root.position[3], root.position[2], root.position[3]);
                    break;
                }
            case 2:
                {
                    ctx.beginPath();
                    ctx.moveTo(root.position[0], root.position[1]);
                    if (anyWay === 1 && anyWayEnable === true) {
                        ctx.lineTo(root.position[0], (root.position[3] - root.position[1]) / 2 + root.position[1]);
                        ctx.lineTo(root.position[2], (root.position[3] - root.position[1]) / 2 + root.position[1]);
                    } else {
                        ctx.lineTo((root.position[2] - root.position[0]) / 2 + root.position[0], root.position[1]);
                        ctx.lineTo((root.position[2] - root.position[0]) / 2 + root.position[0], root.position[3]);
                    }
                    ctx.lineTo(root.position[2], root.position[3]);
                    break;
                }
            }
            ctx.stroke();
        }
    }
}
