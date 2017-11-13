import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:root

    property int gameId: 2;
    signal gameFinished(int id);
    signal startFinishing();

    property int size: 150;
    property int numToKill: 2;
    property int killCont:0;
    property int side: 0;
    property int sidesNum: 4;

    Image
    {
        id:bg;
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/design/qt_game2.png"
        width: root.width
        opacity:0;
    }

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

    PropertyAnimation {id: opacityAnim; target: bg; properties: "opacity"; to: "1"; duration: 500}


    function clean()
    {
       timer.running = false;
       timerForStart.running = false;
       promt.hide();
    }

    function start()
    {
        timerForStart.running = true;
        timer.running = true;
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
        interval: 2500;
        running: false;
        repeat: false;
        onTriggered:
        {
            opacityAnim.start();
            killCont = 0;
            promt.show(gameId);
        }
    }

    Timer
    {
        id:timer;
        interval: 1500;
        running: false;
        repeat: true;
        onTriggered:
        {
          spawnObjects();
        }
    }
}
