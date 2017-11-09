import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:root

    property int gameId: 2;
    signal gameFinished(int id);
    signal startFinishing();

    property int size: 150;
    property int numToKill: 3;
    property int killCont:0;
    property int side: 0;
    property int sidesNum: 4;

    Canvas
    {
        id:canvas
        width: root.width
        height: root.height
    }

    Promt
    {
        id:promt
    }

    function clean()
    {
       timer.running = false;
       timerForStart.running = false;
       promt.hide();
    }

    function start()
    {
        timerForStart.running = true;
    }

    function finish()
    {
        startFinishing();
        gameFinished(gameId);
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
            finish();
        }
    }

    Timer
    {
        id:timerForStart;
        interval: 1000;
        running: false;
        repeat: false;
        onTriggered:
        {
            timer.running = true;
            killCont = 0;
            promt.show(gameId);
        }
    }

    Timer
    {
        id:timer;
        interval: 2500;
        running: false;
        repeat: true;
        onTriggered:
        {
          spawnObjects();
        }
    }
}
