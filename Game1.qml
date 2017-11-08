import QtQuick 2.0
import QtQuick.Controls 2.0
import QtSensors 5.0

Item {
    id:root

    //width:parent.width;
    //height:parent.height;

    property int gameId: 1;
    signal gameFinished(int id);
    property int timecodeForStart: 3700;

    function clean()
    {
        timer.stop();
    }

    function start()
    {
        timer.running = true;
    }

    Timer
    {
        id:timer;
        interval: timecodeForStart;
        running: false;
        repeat: false
        onTriggered:
        {
            opacityAnim1.start();
            opacityAnim2.start();
            opacityAnim3.start();
        }
    }

    PropertyAnimation {id: opacityAnim1; target: top; properties: "opacity"; to: "1"; duration: 500}
    PropertyAnimation {id: opacityAnim2; target: middle; properties: "opacity"; to: "1"; duration: 500}
    PropertyAnimation {id: opacityAnim3; target: bot; properties: "opacity"; to: "1"; duration: 500}

    Text
    {
       //text: "Gyro values: "
       font.family: "Helvetica"
       font.pointSize: 24
       color: "red"
       id:gyroValues;
       anchors.centerIn: parent;
       //text: "X Rotation: " + tilt.reading.xRotation.toFixed(2) + " Y Rotation: " + tilt.reading.yRotation.toFixed(2) ;
    }

    Image
    {
        id:top;
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/design/game1/top.png"
        width: sourceSize.width * tool.getScale();
        x:0;
        y:200;
        opacity:0;
    }

    Image
    {
        id:middle;
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/design/game1/mid.png"
        width: sourceSize.width * tool.getScale();
        x:380;
        y:200;
        opacity:0;
    }

    Image
    {
        id:bot;
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/design/game1/bot.png"
        width: sourceSize.width * tool.getScale();
        x:650;
        y:200;
        opacity:0;
    }

    TiltSensor
    {
        id: tilt
        active: false;

        onReadingChanged:
        {
            var xRot = tilt.reading.xRotation.toFixed(2);
        }
    }

    Tools
    {
        id:tool;
    }
}
