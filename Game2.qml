import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:root
    signal gameFinished(int id);
    property int size: 150;
    property int numToKill: 3;
    property int killCont:0;
    property int side: 0;
    property int sidesNum: 4;

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

    function spawnObjects()
    {
        var component = Qt.createComponent("Capsule.qml");
        var sprite = component.createObject(canvas, { "_parent": root});

        var id = (side++) % sidesNum;
        sprite.start(id);
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

          spawnObjects();
        }
    }


}
