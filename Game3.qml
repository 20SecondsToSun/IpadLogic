import QtQuick 2.0
import QtQuick.Controls 2.0
import QtSensors 5.0
import QtMultimedia 5.8
import QtGraphicalEffects 1.0

Item {
    id:root

    property int gameId:3;
    signal gameFinished(int id);
    signal startFinishing();

    property int yFinished: 630;
    property int angleThreshold: 10;
    property int yIncr: 15;
    property int timecodeForStart: 6100;
    property int gameTime: 5000;

    Image
    {
        id:splash;
        fillMode: Image.PreserveAspectFit
        width:root.width;
        source:"qrc:/images/design/game3/qt_liqud_on.png"
        opacity:0;
    }

    Image
    {
        id:fluid;
        fillMode: Image.PreserveAspectFit
        x: 1565 * tool.getScale();
        y: 800 * tool.getScale();
        width: 128 * tool.getScale();
        height: 434 * tool.getScale();
        source:"qrc:/images/design/game3/Fluid1.png"
        transform: Rotation {id: fluidRot; origin.x: fluid.width * 0.5; origin.y: 0; angle: 0}
        opacity: 0;

        Rectangle
        {
            id:mask;
            x:(fluid.width - width) * 0.5;
            y:-250;
            width: 250
            height: 150
            transform: Rotation {id: maskRot; origin.x: mask.width*0.5; origin.y: mask.height; angle: 0}
            color:"white"
            smooth: true;
            opacity:0;
        }
    }

    PropertyAnimation {id: fluidAnimOut; target: fluid; properties: "opacity"; to: "0"; duration: 500;
        onStopped:
        {
            finish();
        }
    }

    Rectangle
    {
        x: 1565 * tool.getScale();
        y: 800 * tool.getScale();
        width: 128 * tool.getScale();
        height: 434 * tool.getScale();
        color:"white"
        opacity:0
        id:finalsplash
    }

    Image
    {
        id:splash1;
        fillMode: Image.PreserveAspectFit
        width:root.width;
        source:"qrc:/images/design/game3/qt_liqud_off.png"
        opacity:0;
    }

    Promt
    {
        id:promt
    }


    PropertyAnimation {id: finalsplashAnim; target: finalsplash; properties: "opacity"; to: "0"; duration: 500;
        onStopped:
        {
           finish();
        }
    }

    PropertyAnimation {id: yAnimMask; target: mask; properties: "y"; to: "-30"; duration: 600;
        onStopped:
        {
            tilt.active = true;
            rotSensor.active = true;
        }
    }

    PropertyAnimation {id: maskFullYAnim; target: mask; properties: "y"; to: "-250"; duration: 500;}
    PropertyAnimation {id: maskFullHeightAnim; target: mask; properties: "height"; to: "700"; duration: 500;
        onStopped:
        {
            fluid.opacity = 0;
            finalsplash.opacity = 1;
            finalsplashAnim.start();
        }
    }

    PropertyAnimation {id: yAnimMaskSensor; target: mask; properties: "y"; to: "-30"; duration: 600; onStopped:{ rotSensor.active = true;}}
    PropertyAnimation {id: rotAnim; target: fluidRot; properties: "angle"; to: "1"; duration: 300}
    PropertyAnimation {id: yAnim; target: fluid; properties: "y"; to: "1"; duration: 800; onStopped:{finish(); }}
    PropertyAnimation {id: fluidAnim; target: fluid; properties: "opacity"; to: "1"; duration: 400;
        onStopped:
        {
            splash.opacity = 0;
            mask.opacity = 1;
            yAnimMask.start();
        }
    }

    PropertyAnimation {id: opacityAnim; target: splash; properties: "opacity"; to: "1"; duration: 500;
        onStopped:
        {
            splash1.opacity = 1;
            fluidAnim.start();
        }
    }

    function start()
    {
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
        id:gameTimer;
        interval: gameTime;
        running: false;
        repeat: false
        onTriggered:
        {
            tilt.active = false;
            rotSensor.active = false;
            maskRot.angle = 0;
            maskFullHeightAnim.start();
            maskFullYAnim.start();
        }
    }

    Timer
    {
        id:timer;
        interval: timecodeForStart;
        running: false;
        repeat: false
        onTriggered:
        {
            splash.opacity = 1;
            splash1.opacity = 1;
            fluidAnim.start();
            promt.show(gameId);
        }
    }

    TiltSensor
    {
        id: tilt
        active: false;
        dataRate:40;

        onReadingChanged:
        {
            var xRot = tilt.reading.xRotation.toFixed(0);
            var maxAngle = 45;
            maskRot.angle = -(xRot > maxAngle ? maxAngle : (xRot < -maxAngle ? -maxAngle : xRot));
        }
    }

    property real yRotOld:0;
    property bool wasCriticalAngles:false;
    property int thresholdAngleDiff: 20;
    property real calibrateAngle: -900;
    property bool isCalibrateAngleSet: false;

    RotationSensor
    {
        id: rotSensor
        active: false;
        dataRate:10;
        onReadingChanged:
        {
            var yRot = rotSensor.reading.y.toFixed(0);
            var diff = yRot - yRotOld;

            if(!isCalibrateAngleSet)
            {
                isCalibrateAngleSet = true;
                calibrateAngle = yRot;
            }

            var diffAbs = Math.abs(yRot - calibrateAngle);

            if(diff > 1)
            {
                diff = 10;
                animateMask(diff)
            }
            else if(diff < -1)
            {
                diff = -10;
                animateMask(diff)
            }

            if(!wasCriticalAngles && checkCriticalValues(diffAbs))
            {
                wasCriticalAngles = true;
                gameTimer.running = true;
            }

            yRotOld = yRot;
        }
    }

    function checkCriticalValues(diff)
    {
        return diff > thresholdAngleDiff;
    }

    function animateMask(diff)
    {
        if(!yAnimMaskSensor.running)
        {
            yAnimMaskSensor.stop();
            yAnimMaskSensor.duration = 100;
            yAnimMaskSensor.to =  tool.clamp(mask.y + diff, -120, 0);
            yAnimMaskSensor.start();
        }
    }

    Tools
    {
        id:tool;
    }
}
