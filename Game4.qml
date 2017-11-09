import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:root
    width:parent.width;
    height:parent.height;
    signal gameFinished(int id);
    property int gameId:4;

    property int timecodeForStart: 3900;

    property int clickNum:0;
    property int clickToWin:5;
    property int widthIncrement: 80;
    property int startWidth: 100;
    property int endWidth: 590;
    property int currentWIdth;
    property bool lastClick:false;


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

    PropertyAnimation {id: opacityAnim; target: circle; properties: "opacity"; to: "1"; duration: 500}

    PropertyAnimation {id: widthAnim; target: circle; properties: "width"; to: "200"; duration: 300}
    PropertyAnimation {id: xAnim; target: circle; properties: "x"; to: "200"; duration: 300}
    PropertyAnimation {id: yAnim; target: circle; properties: "y"; to: "200"; duration: 300
        onStopped:
        {
            if(lastClick)
            {
                onOutTimer.start();

            }
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
       opacity:0.2
    }

    function clickBRB()
    {
        if(lastClick)
        {
            return;
        }

        currentWIdth += widthIncrement;
        var nextWidth = currentWIdth;


        if(++clickNum > clickToWin)
        {
            nextWidth = endWidth;
            lastClick = true;
            timer.stop();
        }
        else
        {
            timer.restart();
            timer.running = true;
        }

        startAnimation(nextWidth);
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
        currentWIdth = circle.width;
        lastClick = false;
        timerShow.running = true;
    }

    Timer
    {
        id:onOutTimer;
        interval: 1500;
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
            promt.show(gameId);
            splash.opacity = 1;
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
          clickNum = 0;

          currentWIdth = startWidth;
          var nextWidth = startWidth;
          startAnimation(nextWidth);
        }
    }

    function startAnimation(_width)
    {
        widthAnim.to = _width;
        xAnim.to = circle.x - _width/2 + circle.width/2;
        yAnim.to = circle.y - _width/2 + circle.width/2;

        widthAnim.start();
        xAnim.start();
        yAnim.start();
    }

    Tools
    {
        id:tool;
    }

}
