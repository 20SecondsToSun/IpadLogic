import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
     id:root
     width:parent.width;
     height:parent.height;

     property int size;
     property variant _parent;
     property int deathTime:6000;

     property var locations:
     [
      {x0:-100, y0: 0, x1:root.width + tool.getRandInt(200, 400), y1:0 },
      {x0:root.width + tool.getRandInt(200, 400), y0: 0, x1:-100, y1:0 },
      {x0:0, y0: -100, x1:0, y1:root.height + tool.getRandInt(200, 400) },
      {x0:0, y0: root.height + tool.getRandInt(200, 400), x1:0, y1:-100 }
     ]

    Image
    {
        id:promt;
        fillMode: Image.PreserveAspectFit
        width:200;
        source:"qrc:/images/design/Capsule.png"
        Button
        {
            width:promt.width;
            height:promt.height;
            opacity: 0;
            onClicked:
            {
                timer.running = false;
                rotAnimation.stop();
                xAnimation.stop();
                yAnimation.stop();
                _parent.onKilled();
                alphaAnimation.start();
            }
        }

        rotation: Math.random()*360;
    }

    PropertyAnimation {id: rotAnimation; target: promt; properties: "rotation"; to: "360"; duration: deathTime}
    PropertyAnimation {id: xAnimation; target: promt; easing.type: Easing.OutInExpo; properties: "x"; to: "0"; duration: deathTime}
    PropertyAnimation {id: yAnimation; target: promt; easing.type: Easing.OutInExpo; properties: "y"; to: "0"; duration: deathTime}
    PropertyAnimation {id: alphaAnimation; target: promt; properties: "opacity"; to: "0"; duration: 400;
        onStopped:
        {
            root.destroy();
        }
    }

    function start(id)
    {
        switch(id)
        {
           case 0:
           case 1:
                promt.x = locations[id].x0;
                promt.y = yRange();
                xAnimation.to = locations[id].x1;
                yAnimation.to = yRange();
          break;

          case 2:
          case 3:
                promt.x = xRange();
                promt.y = locations[id].y0;
                xAnimation.to = xRange();
                yAnimation.to = locations[id].y1;
            break;
        }

        rotAnimation.start();
        xAnimation.start();
        yAnimation.start();
    }

    function yRange()
    {
        return root.height * Math.random();
    }

    function xRange()
    {
        return root.width * Math.random();
    }

    Timer
    {
        id:timer;
        interval: deathTime;
        running: true;
        repeat: false;
        onTriggered:
        {
          root.destroy();
        }
    }

    Tools
    {
        id:tool;
    }
}
