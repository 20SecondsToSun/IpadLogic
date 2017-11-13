import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:root

    signal startFinishing();
    signal gameFinished(int id);

    property int gameId:4;
    property int timecodeForStart: 2300;
    property int clickNum:0;
    property int clickToWin:3;
    property int widthIncrement: 150;
    property int startWidth: 1;
    property int endWidth: 595;
    property int currentWIdth: 0;
    property bool lastClick:false;

    property bool isFinished: false;

    Rectangle
    {
         id:circle;
         width: startWidth
         height: width
         color: "#b0c1cb"
         radius: width*0.5;
         x:696*tool.getScale() - width*0.5;
         y:762*tool.getScale() - width*0.5;
         opacity:0;
    }

    Image
    {
        id:splash;
        fillMode: Image.PreserveAspectFit
        width:root.width;
        source:"qrc:/images/design/game4Overlay.png"
        opacity:0;
    }

    PropertyAnimation {id: splashOpacityAnim; target: splash; properties: "opacity"; to: "1"; duration: 500}
    PropertyAnimation {id: opacityAnim; target: circle; properties: "opacity"; to: "1"; duration: 500}
    PropertyAnimation {id: widthAnim; target: circle; properties: "width"; to: "200"; duration: 2000}
    PropertyAnimation {id: xAnim; target: circle; properties: "x"; to: "200"; duration: 2000}
    PropertyAnimation {id: yAnim; target: circle; properties: "y"; to: "200"; duration: 2000
        onStopped:
        {
            if(lastClick && !isFinished)
            {
                isFinished = true;
                onOutTimer.start();
                root.startFinishing();
            }
            if(lastClick)
                startAnimation(1700, 500);
        }}

    Promt
    {
        id:promt
    }

    Button
    {
       onClicked: clickBRB()
       width: 700;
       height: 500;
       anchors.verticalCenter: root.verticalCenter
       anchors.right: root.right;
       opacity:0.
    }

    function clickBRB()
    {
        if(lastClick)
        {
            return;
        }

        if(++clickNum > clickToWin)
        {

            lastClick = true;
           // timer.stop();
        }
        else
        {
            //timer.restart();
            //timer.running = true;
        }

        currentWIdth += widthIncrement;

        //if(clickNum == 1)
        {
            startAnimation(currentWIdth, 500);
        }
    }

    function clean()
    {
        onOutTimer.stop();
        timer.stop();
        timerShow.running = false;
        promt.hide();
    }

    function start()
    {
        clickNum = 0;
        currentWIdth = circle.width;
        lastClick = false;
        timerShow.running = true;
        isFinished = false;
    }

    function finish()
    {
        root.startFinishing();
        onOutTimer.start();
    }

    Timer
    {
        id:onOutTimer;
        interval: 1000;
        running: false;
        repeat: false;
        onTriggered:
        {
            gameFinished(gameId);
            splash.opacity = 0;
        }
    }

    Timer
    {
        id:timerShow;
        interval: timecodeForStart;
        running: false;
        repeat: false;
        onTriggered:
        {
            opacityAnim.start();
            splashOpacityAnim.start();
            promt.show(gameId);
            //splash.opacity = 1;
        }
    }

    Timer
    {
        id:timer;
        interval: 500;
        running: false;
        repeat: false;
        onTriggered:
        {
            if(!lastClick)
            {
                clickNum = 0;
                //startAnimation(startWidth, 300);
            }
        }
    }

    function startAnimation(_width, dur)
    {
        widthAnim.to = _width;
        xAnim.to = circle.x - _width/2 + circle.width/2;
        yAnim.to = circle.y - _width/2 + circle.width/2;

        xAnim.duration = yAnim.duration = widthAnim.duration = dur;

        widthAnim.stop();
        xAnim.stop();
        yAnim.stop();

        widthAnim.start();
        xAnim.start();
        yAnim.start();
    }

    Tools
    {
        id:tool;
    }

}
