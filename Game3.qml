import QtQuick 2.0
import QtQuick.Controls 2.0
import QtSensors 5.0
import QtMultimedia 5.8

Item {
    id:root

    property int gameId:3;
    signal gameFinished(int id);
    signal startFinishing();

    property int yFinished: 630;
    property int angleThreshold: 10;
    property int yIncr: 10;

    property int timecodeForStart: 6300;

    Image
    {
        id:fluid;
        fillMode: Image.PreserveAspectFit
        x:1568 *tool.getScale();
        width: 128*tool.getScale();
        y:794*tool.getScale();
        height: 434 *tool.getScale();
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


    Promt
    {
        id:promt
    }

    PropertyAnimation {id: rotAnim; target: fluidRot; properties: "angle"; to: "1"; duration: 300}
    PropertyAnimation {id: yAnim; target: fluid; properties: "y"; to: "1"; duration: 300}


    PropertyAnimation {id: fluidAnim; target: fluid; properties: "opacity"; to: "1"; duration: 500}
    PropertyAnimation {id: splashAnim; target: splash; properties: "opacity"; to: "1.0"; duration: 300;
                                                                                                 onStopped:
                                                                                                 {
                                                                                                    // videoAnim.start();
                                                                                                    // video.play();
                                                                                                    // video.pause();

                                                                                                 }}

    function start()
    {
        tilt.active = true;
        timer.running = true;
    }

    function clean()
    {
        timer.running = false;
        promt.hide();
    }

    function finish()
    {
        startFinishing();
        gameFinished(gameId);
    }

    Timer
    {
        id:timer;
        interval: timecodeForStart;
        running: false;
        repeat: false
        onTriggered:
        {
            fluid.opacity = 1;
            splash.opacity = 1;
            //fluidAnim.start();
            //splashAnim.start();


            promt.show(gameId);
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
                //rotAnim.to = xRot;
                //rotAnim.start();
                yAnim.to = fluid.y + yIncr;
                yAnim.start();
                //video.play();
            }
            else
            {
               // video.pause();
            }

            if(yAnim.to >= yFinished)
            {
                finish();
               // video.pause();
            }
        }
    }

    Tools
    {
        id:tool;
    }
}
