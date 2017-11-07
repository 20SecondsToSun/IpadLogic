import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:root
    signal gameFinished(int id);
    property int size: 150;
    property int numToKill: 3;
    property int killCont:0;

    Rectangle
    {
        width:root.width;
        height:root.height;
        color:"red";
    }

    Canvas
    {
        id:canvas
        width: parent.width
        height: parent.height
    }

    function clean()
    {
       console.log("clean---------", killCont);
       timer.running = false;
    }

    function start()
    {
        timer.running = true;
        killCont = 0;
    }

    function spawnObjects(x, y)
    {
        var component = Qt.createComponent("Capsule.qml");
        var size = 100;//Math.min(bg.width/2.2, 500);
        var sprite = component.createObject(canvas,
                                            {"x": x - size*0.5,
                                             "y": y - size*0.5,
                                             "size":size, "_parent": root});

    }

    function onKilled()
    {
         if(++killCont > numToKill)
        {
            gameFinished(2);
        }
    }

    Timer
    {
        id:timer;
        interval: 2000;
        running: false;
        repeat: true;
        onTriggered:
        {
          spawnObjects(root.width*Math.random(), root.height*Math.random());
        }
    }
}
