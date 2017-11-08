import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:root
    width:parent.width;
    height:parent.height;
    signal gameFinished(int id);

    property int clickNum:0;
    property int clickToWin:5;
    property int widthIncrement: 50;
    property int startWidth: 100;
    property int endWidth: 350;
    property int currentWIdth;
    property bool lastClick:false;

    Rectangle
    {
        width:root.width;
        height:root.height;
        color:"gray";
    }

    Rectangle
    {
         id:circle;
         width: startWidth
         height: width
         color: "red"
         radius: width*0.5;
         x:200;
         y:200;
    }

    Rectangle
    {
         color: "white"
         x:250;
         y:250;
         width: 6
         height: width
    }

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

    Button
    {
       onClicked: clickBRB()
       width: 700;
       height: 500;
       anchors.verticalCenter: root.verticalCenter
       anchors.right: root.right;
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
    }

    function start()
    {
        currentWIdth = circle.width;
        lastClick = false;
    }

    Timer
    {
        id:onOutTimer;
        interval: 1500;
        running: false;
        repeat: false;
        onTriggered:
        {
             gameFinished(4);
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
}
