import QtQuick 2.7
import QtQuick.Controls 2.0
import QtSensors 5.0

Item {
    id:root

    property int gameId: 1;
    signal gameFinished(int id);
    signal startFinishing();
    property int timecodeForStart: 4100;
    property int outAnimDuration: 100;
    property int angleThreshold: 10;
    property int state:1;

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
       startAnimations(coords[1], 200);
       tilt.active = false;
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

    function resumeAnimations()
    {
        x1Anim.resume();
        y1Anim.resume();
        x2Anim.resume();
        y2Anim.resume();
        x3Anim.resume();
        y3Anim.resume();
    }

    function pauseAnimations()
    {
        x1Anim.pause();
        y1Anim.pause();
        x2Anim.pause();
        y2Anim.pause();
        x3Anim.pause();
        y3Anim.pause();
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
           // middle.opacity = 1;
           // bot.opacity = 1;
            promt.show(gameId);
        }
    }

    Timer
    {
        id:timerOut;
        interval: 1100;
        running: false;
        repeat: false
        onTriggered:
        {
           // bg.opacity = 0;
            gameFinished(gameId);
        }
    }

    PropertyAnimation {id: opacityAnim1; target: top; properties: "opacity"; to: "1"; duration: 500; onStopped:
    {
       opacityAnim4.start();
       startAnimations(coords[2], 1500);
    }}

    PropertyAnimation {id: opacityAnim2; target: middle; properties: "opacity"; to: "1"; duration: 500}

    PropertyAnimation {id: opacityAnim3; target: bot; properties: "opacity"; to: "1"; duration: 500}
    PropertyAnimation {id: opacityAnim4; target: bg; properties: "opacity"; to: "1"; duration: 100}

    PropertyAnimation{id:x1Anim; target: top; properties: "x"; to: coords[1].x10; duration: outAnimDuration;
                                                                                            onStopped:
                                                                                            {
                                                                                                console.log("animations finished  ", state)
                                                                                                if(state == 1)
                                                                                                {
                                                                                                     tilt.active = true;
                                                                                                    // startAnimations(coords[1], 2000);
                                                                                                  //   pauseAnimations();
                                                                                                     state = 2;
                                                                                                }
                                                                                                else if (state == 2)
                                                                                                {
                                                                                                    console.log("START FINISHING!!!!!!!!!!!")
                                                                                                    root.startFinishing();
                                                                                                    timerOut.running = true;
                                                                                                    tilt.active = false;
                                                                                                }
                                                                                            }
                                                                                        }

    PropertyAnimation{id:y1Anim;
        target: top;
        properties: "y";
        to: coords[1].y10;
        duration: outAnimDuration

    }

    PropertyAnimation{id:x2Anim; target: middle; properties: "x"; to: coords[1].x20; duration: outAnimDuration}
    PropertyAnimation{id:x3Anim; target: bot; properties: "x"; to: coords[1].x30; duration: outAnimDuration}

    PropertyAnimation{id:y2Anim; target: middle; properties: "y"; to: coords[1].y20; duration: outAnimDuration}
    PropertyAnimation{id:y3Anim; target: bot; properties: "y"; to: coords[1].y30; duration: outAnimDuration}

    property var coords:
    [
        {x10:-15, y10:465, x20:401, y20:511, x30:625, y30:356},
        {x10:-17, y10:444, x20:368, y20:426, x30:629, y30:391},
        {x10:-20, y10:262, x20:365, y20:360, x30:629, y30:616}
    ];

    Image
    {
        id:bg;
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/design/qt_game1.png"
        width: root.width
        opacity:0;
    }

    Image
    {
        id:top;
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/design/game1/top.png"
        width: sourceSize.width * tool.getScale();
        x:coords[0].x10
        y:coords[0].y10;
        opacity:0;
        transform: Rotation {id: rot1;  angle: -4.8; origin.x:top.width*0.5; origin.y: top.height*0.5;}
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
        transform: Rotation {id: rot2;  angle: -4.8; origin.x:middle.width*0.5; origin.y: middle.height*0.5;}
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

    property real angle: -4.8;

    Keys.onPressed:
    {
        var sign2 = 1;
        var factor2 = 2.2;
         var factor3 = 1.8;
           if (event.key == Qt.Key_Up)
           {

               if(middle.y + sign2 * Math.sin(angle) < 290 || middle.y + sign2 * Math.sin(angle) > 600)
                   return;
               middle.x+= sign2 * Math.cos(angle);
               middle.y+= sign2 * Math.sin(angle);
               top.x+= factor2*sign2 * Math.cos(angle);
               top.y+= factor2*sign2 * Math.sin(angle);
               bot.x-= factor3*sign2 * Math.cos(angle);
               bot.y-= factor3*sign2 * Math.sin(angle);
               event.accepted = true;
           }

           if (event.key == Qt.Key_Down)
           {
                sign2 = -1;
               if(middle.y + sign2 * Math.sin(angle) < 290 || middle.y + sign2 * Math.sin(angle) > 600)
                   return;

               middle.x+= sign2 * Math.cos(angle);
               middle.y+= sign2 * Math.sin(angle);
               top.x+= factor2*sign2 * Math.cos(angle);
               top.y+= factor2*sign2 * Math.sin(angle);
               bot.x-= factor3*sign2 * Math.cos(angle);
               bot.y-= factor3*sign2 * Math.sin(angle);
               event.accepted = true;
           }

           if (event.key == Qt.Key_Left)
           {
               rotate(1);
           }
           if (event.key == Qt.Key_Right)
           {
               rotate(-1);
           }


            console.log(middle.y)

           if(checkCond())
           {
               ready = true;
             //  finish();
             //  resumeAnimations()
               startAnimations(coords[1], 200);
           }
       }
    focus: true

    property bool ready:false;

    TiltSensor
    {
        id: tilt
        active: false;

        onReadingChanged:
        {
            var xRot = tilt.reading.xRotation.toFixed(2);

            var yRot = tilt.reading.yRotation.toFixed(2);
            gyro.text = yRot;


            if(xRot > angleThreshold || xRot < -angleThreshold )
            {
               var sign = xRot > 0 ? 1: -1;
               rotate(sign);
                //resumeAnimations();
            }
            else
            {
               // pauseAnimations();
            }

            if(yRot > angleThreshold || yRot < -angleThreshold )
            {
                var sign2 = (yRot + 90) > 0 ? 1: -1;
                middle.x+= sign2 * Math.cos(-4.8);
                middle.y+= sign2 * Math.sin(-4.8);
            }
        }
    }

    function rotate(factor)
    {
        rot1.angle += factor;
        rot2.angle += factor;
        rot3.angle += factor;
    }

    function checkCond()
    {
        return middle.x > 373 && middle.x < 374.5 && rot1.angle > -5 && rot1.angle < -4 && !ready;
    }

    Timer {
            id:updater;
            running: true;
            repeat: true;
            interval: 500;
            onTriggered:
            {
               //rotate(1);

                if(checkCond())
                {
                   // startAnimations(coords[1], 200);
                }
            }
        }

    Tools
    {
        id:tool;
    }
}
