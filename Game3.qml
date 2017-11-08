import QtQuick 2.0
import QtQuick.Controls 2.0
import QtSensors 5.0

Item {
    id:root

    width:parent.width;
    height:parent.height;

    property int gameId:3;
    signal gameFinished(int id);

    property int yFinished: 630;
    property int angleThreshold: 10;
    property int yIncr: 10;

    property int timecodeForStart: 6000;

    Image
    {
        id:fluid;
        fillMode: Image.PreserveAspectFit
        x:750;
        y:300;
        source:"qrc:/images/design/game3/Fluid1.png"
        transform: Rotation {id: fluidRot; origin.x: fluid.width * 0.5; origin.y: 0; angle: 0}
        opacity:0;
    }

    Image
    {
        id:splash;
        fillMode: Image.PreserveAspectFit
        width:root.width;
        source:"qrc:/images/design/game3Overlay.png"
         opacity:0;
    }

    PropertyAnimation {id: rotAnim; target: fluidRot; properties: "angle"; to: "1"; duration: 300}
    PropertyAnimation {id: yAnim; target: fluid; properties: "y"; to: "1"; duration: 300}


    PropertyAnimation {id: fluidAnim; target: fluid; properties: "opacity"; to: "1"; duration: 500}
    PropertyAnimation {id: splashAnim; target: splash; properties: "opacity"; to: "1"; duration: 500}


    function start()
    {
        tilt.active = true;
        timer.running = true;
    }

    function clean()
    {
        timer.running = false;
    }

    Timer
    {
        id:timer;
        interval: timecodeForStart;
        running: false;
        repeat: false
        onTriggered:
        {
            fluidAnim.start();
            splashAnim.start();
        }
    }

    TiltSensor
    {
        id: tilt
        active: false;

        onReadingChanged:
        {
            var xRot = tilt.reading.xRotation.toFixed(2);

            if(xRot > angleThreshold || xRot < -angleThreshold )
            {
                rotAnim.to = xRot;
                rotAnim.start();
                yAnim.to = fluid.y + yIncr;
                yAnim.start();
            }

            if(yAnim.to >= yFinished)
            {
                gameFinished(gameId);
            }
        }
    }
}
