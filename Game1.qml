import QtQuick 2.0
import QtQuick.Controls 2.0
import QtSensors 5.0

Item {
    id:root

    property int gameId: 1;
    signal gameFinished(int id);
    signal startFinishing();
    property int timecodeForStart: 4100;

    property int outAnimDuration: 100;

    function clean()
    {
        timer.stop();
        promt.hide();
    }

    function start()
    {
        timer.running = true;
    }

    function finish()
    {
        root.startFinishing();
        x1Anim.start();
        y1Anim.start();
        x2Anim.start();
        y2Anim.start();
        x3Anim.start();
        y3Anim.start();
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
            promt.show(gameId);
        }
    }

    Timer
    {
        id:timerOut;
        interval: 500;
        running: false;
        repeat: false
        onTriggered:
        {
            gameFinished(gameId);
        }
    }

    PropertyAnimation {id: opacityAnim1; target: top; properties: "opacity"; to: "1"; duration: 500}
    PropertyAnimation {id: opacityAnim2; target: middle; properties: "opacity"; to: "1"; duration: 500}
    PropertyAnimation {id: opacityAnim3; target: bot; properties: "opacity"; to: "1"; duration: 500}

    PropertyAnimation{id:x1Anim; target: top; properties: "x"; to: coords[1].x10; duration: outAnimDuration;
                                                                                            onStopped:
                                                                                            {
                                                                                                timerOut.running = true;
                                                                                            }
                                                                                        }

    PropertyAnimation{id:y1Anim; target: top; properties: "y"; to: coords[1].y10; duration: outAnimDuration}

    PropertyAnimation{id:x2Anim; target: middle; properties: "x"; to: coords[1].x20; duration: outAnimDuration}
    PropertyAnimation{id:x3Anim; target: bot; properties: "x"; to: coords[1].x30; duration: outAnimDuration}

    PropertyAnimation{id:y2Anim; target: middle; properties: "y"; to: coords[1].y20; duration: outAnimDuration}
    PropertyAnimation{id:y3Anim; target: bot; properties: "y"; to: coords[1].y30; duration: outAnimDuration}

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

    property var coords:
    [
        {x10:-16, y10:482, x20:400, y20:525, x30:625, y30:374},
        {x10:-20, y10:462, x20:365, y20:440, x30:629, y30:406}
    ];

    Image
    {
        id:top;
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/design/game1/top.png"
        width: sourceSize.width * tool.getScale();
        x:coords[0].x10
        y:coords[0].y10;
        opacity:0;
        transform: Rotation {id: rot1;  angle: -4.8}
    }

    Image
    {
        id:middle;
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/design/game1/mid.png"
        width: sourceSize.width * tool.getScale();
        x:coords[0].x20;
        y:coords[0].y20;
        opacity:0;
        transform: Rotation {id: rot2;  angle: -4.8}
    }

    Image
    {
        id:bot;
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/design/game1/bot.png"
        width: sourceSize.width * tool.getScale();
        x:coords[0].x30;
        y:coords[0].y30;
        opacity:0;
        transform: Rotation {id: rot3;  angle: -4.8}
    }

    Promt
    {
        id:promt
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
