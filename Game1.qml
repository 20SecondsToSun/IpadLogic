import QtQuick 2.7
import QtQuick.Controls 2.0
import QtSensors 5.1

Item {
    id:root

    property int gameId: 1;
    signal gameFinished(int id);
    signal startFinishing();
    property int timecodeForStart: 3600;
    property int timecodeForEnd: 1100;
    property int outAnimDuration: 100;
    property int angleThreshold: 10;
    property int state:1;
    property real startAngle:0;
    property bool startAngleFixed: false;

    property var coords:
    [
        {x10:-15, y10:465, x20:401, y20:511, x30:625, y30:356},
        {x10:-17, y10:444, x20:368, y20:426, x30:631, y30:389},
        {x10:-20, y10:262, x20:365, y20:360, x30:629, y30:616}
    ];

    Image
    {
        id:bg;
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/design/game1/qt_game1.png"
        width: root.width
        opacity:0;
    }

    Image
    {
        id:top;
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/design/game1/top.png"
        width: sourceSize.width * tool.getScale();
        x:coords[1].x10
        y:coords[1].y10;
        opacity:0;
        transform: Rotation {id: rot1;  angle: -4.8; origin.x:top.width*0.5; origin.y: top.height*0.5;}
    }

    Image
    {
        id:middle;
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/design/game1/mid.png"
        width: sourceSize.width * tool.getScale();
        x:coords[1].x20;
        y:coords[1].y20;
        opacity:0;
        transform: Rotation {id: rot2;  angle: -4.8; origin.x:middle.width*0.5; origin.y: middle.height*0.5;}
    }

    Image
    {
        id:bot;
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/design/game1/bot.png"
        width: sourceSize.width * tool.getScale();
        x:coords[1].x30;
        y:coords[1].y30;
        opacity:0;
        transform: Rotation {id: rot3;  angle: -4.8; origin.x:bot.width*0.5; origin.y: bot.height*0.5;}
    }

    Text
    {
        id:gyro
    }

    Promt
    {
        id:promt
    }


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
        tilt.active = false;
        rotSensor.active = false;
        state = 2;
        var secs = 200;
        startAnimations(coords[1], secs);

        rot1Anim.stop();
        rot2Anim.stop();
        rot3Anim.stop();

        rot1Anim.duration = secs;
        rot2Anim.duration = secs;
        rot3Anim.duration = secs;

        rot1Anim.to = angleEnd;
        rot2Anim.to = angleEnd;
        rot3Anim.to = angleEnd;

        rot1Anim.start();
        rot2Anim.start();
        rot3Anim.start();
    }

    function startAnimations(coord, dur)
    {
        x1Anim.stop();
        y1Anim.stop();
        x2Anim.stop();
        y2Anim.stop();
        x3Anim.stop();
        y3Anim.stop();

        x1Anim.duration = dur;
        y1Anim.duration = dur;
        x2Anim.duration = dur;
        y2Anim.duration = dur;
        x3Anim.duration = dur;
        y3Anim.duration = dur;

        x1Anim.to = coord.x10;
        y1Anim.to = coord.y10;
        x2Anim.to = coord.x20;
        y2Anim.to = coord.y20;
        x3Anim.to = coord.x30;
        y3Anim.to = coord.y30;

        x1Anim.start();
        y1Anim.start();
        x2Anim.start();
        y2Anim.start();
        x3Anim.start();
        y3Anim.start();
    }

    function startAnimationsTo(dur, x1, y1, x2, y2, x3, y3)
    {
        x1Anim.stop();
        y1Anim.stop();
        x2Anim.stop();
        y2Anim.stop();
        x3Anim.stop();
        y3Anim.stop();

        x1Anim.duration = dur;
        y1Anim.duration = dur;
        x2Anim.duration = dur;
        y2Anim.duration = dur;
        x3Anim.duration = dur;
        y3Anim.duration = dur;

        x1Anim.to = x2;
        y1Anim.to = y2;
        x2Anim.to = x1;
        y2Anim.to = y1;
        x3Anim.to = x3;
        y3Anim.to = y3;

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
        interval: timecodeForEnd;
        running: false;
        repeat: false
        onTriggered:
        {
            gameFinished(gameId);
        }
    }

    PropertyAnimation {id: opacityAnim1; target: top; properties: "opacity"; to: "1"; duration: 500; onStopped:
    {
       opacityAnim4.start();
//            angleAnimDuration = 1500;
//            rot1Anim.to = 4;
//            rot2Anim.to = -2;
//            rot3Anim.to = 3;

//            rot1Anim.start();
//            rot2Anim.start();
//            rot3Anim.start();

       startAnimations(coords[2], 500);
    }}

    PropertyAnimation {id: opacityAnim2; target: middle; properties: "opacity"; to: "1"; duration: 500}
    PropertyAnimation {id: opacityAnim3; target: bot; properties: "opacity"; to: "1"; duration: 500}
    PropertyAnimation {id: opacityAnim4; target: bg; properties: "opacity"; to: "1"; duration: 100}

    PropertyAnimation{id:x1Anim; target: top; properties: "x"; to: coords[1].x10; duration: outAnimDuration;
                                                                                            onStopped:
                                                                                            {
                                                                                                if(state == 1)
                                                                                                {
                                                                                                     tilt.active = true;
                                                                                                     rotSensor.active = true;
                                                                                                     startAngleFixed = false;
                                                                                                     angleAnimDuration = 100;
                                                                                                     state = 3;
                                                                                                }
                                                                                                else if (state == 2)
                                                                                                {
                                                                                                    root.startFinishing();
                                                                                                    timerOut.running = true;
                                                                                                    tilt.active = false;
                                                                                                    rotSensor.active = false;
                                                                                                    state = -1;
                                                                                                }
                                                                                            }
                                                                                        }

    PropertyAnimation{id:y1Anim; target: top; properties: "y"; to: coords[1].y10; duration: outAnimDuration}
    PropertyAnimation{id:x2Anim; target: middle; properties: "x"; to: coords[1].x20; duration: outAnimDuration}
    PropertyAnimation{id:x3Anim; target: bot; properties: "x"; to: coords[1].x30; duration: outAnimDuration}
    PropertyAnimation{id:y2Anim; target: middle; properties: "y"; to: coords[1].y20; duration: outAnimDuration}
    PropertyAnimation{id:y3Anim; target: bot; properties: "y"; to: coords[1].y30; duration: outAnimDuration}

    property real angleAnimDuration:100;
    PropertyAnimation{id:rot1Anim; target: rot1; properties: "angle"; to:0; duration: angleAnimDuration}
    PropertyAnimation{id:rot2Anim; target: rot2; properties: "angle"; to:0; duration: angleAnimDuration}
    PropertyAnimation{id:rot3Anim; target: rot3; properties: "angle"; to:0; duration: angleAnimDuration}

    property real angle: -4.8;
    property real angleEnd: -4.8;

    property bool ready:false;
    property real xRotPrev: 0;
    property real yRotPrev: 0;

    property string direction : "down";

    TiltSensor
    {
        id: tilt
        active: false;
        dataRate: 30;
        skipDuplicates:true;

        onReadingChanged:
        {
            var xRot = tilt.reading.xRotation.toFixed(0);
            var yRot = tilt.reading.yRotation.toFixed(0);


            if(xRotPrev !== xRot)
                rotate(xRot);
            xRotPrev = xRot;

//            if(!startAngleFixed)
//            {
//               // calibrate()

//                startAngleFixed = true;
//                startAngle = yRot;
//                xRotPrev = xRot;
//                yRotPrev = yRot;
//            }

//            if(direction == "down")
//            {
//               if(yRotPrev - yRot > 5)
//               {
//                   direction = "up";
//                   yRotPrev = yRot;
//               }
//            }
//            else if(direction == "up")
//            {
//               if(yRotPrev - yRot < -5)
//               {
//                   direction = "down";
//                   yRotPrev = yRot;
//               }
//            }

            if(checkCond())
            {
                tilt.active = false;
                rotSensor.active = false;
                ready = true;
                state = 2;
                finish();
            }
        }
    }



    property real yRotOld:0;
    property real calibrateAngle: -900;
    property bool isCalibrateAngleSet: false;

    RotationSensor
    {
        id: rotSensor
        active: false;
        dataRate:5;
        onReadingChanged:
        {
            var yRot = rotSensor.reading.y.toFixed(0);
            var diff = yRot - yRotOld;

            if(!isCalibrateAngleSet)
            {
                isCalibrateAngleSet = true;
                calibrateAngle = yRot;
               // moveUp(180);//-60
                //moveDown(60);
            }

            var diffCalibrate = yRot - calibrateAngle;
           //console.log("diffCalibrate  ", diffCalibrate);

            if(diffCalibrate > 1)
            {
               var moveF = tool.map(diffCalibrate, -60, 0, 0, 180);
              // console.log("moveF  ", moveF);
               moveDown(20);
            }
            else if(diffCalibrate < -1)
            {
                var moveF1 = tool.map(diffCalibrate, 0, 60, 0, 60);

                moveUp(40);
            }

            yRotOld = yRot;
        }
    }

    function moveUp(factor)
    {
        var sign2 = factor;
        var factor2 = 2.2;
        var factor3 = 1.8;

        if(middle.y + sign2 * Math.sin(angle) < 290 || middle.y + sign2 * Math.sin(angle) > 600)
            return;

        startAnimationsTo(300,
                   middle.x + sign2 * Math.cos(angle),
                   middle.y + sign2 * Math.sin(angle),
                   top.x+ factor2*sign2 * Math.cos(angle),
                   top.y+ factor2*sign2 * Math.sin(angle),
                   bot.x- factor3*sign2 * Math.cos(angle),
                   bot.y- factor3*sign2 * Math.sin(angle)
                          )
    }

    function moveDown(factor)
    {
        var factor2 = 2.2;
        var factor3 = 1.8;
        var sign2 = -factor;
       if(middle.y + sign2 * Math.sin(angle) < 290 || middle.y + sign2 * Math.sin(angle) > 600)
           return;

       startAnimationsTo(300,
                  middle.x+sign2 * Math.cos(angle),
                  middle.y+ sign2 * Math.sin(angle),
                  top.x+ factor2*sign2 * Math.cos(angle),
                  top.y+ factor2*sign2 * Math.sin(angle),
                  bot.x- factor3*sign2 * Math.cos(angle),
                  bot.y- factor3*sign2 * Math.sin(angle)
                         )
    }

    function rotate(factor)
    {
        rot1Anim.to = factor;
        rot2Anim.to = factor;
        rot3Anim.to = factor;

        rot1Anim.start();
        rot2Anim.start();
        rot3Anim.start();
//        rot1.angle = factor;
//        rot2.angle = factor;
//        rot3.angle = factor;
    }

    function checkCond()
    {
        return middle.x > 372 && middle.x < 376 && rot1.angle > -11 && rot1.angle < 0 && !ready;
    }

    Tools
    {
        id:tool;
    }
}
