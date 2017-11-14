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
    property int side:0;
    property int sidesNum:4;

    property  int  timeForFinish: 100
    property  int  timeForStart: 2000
    property  int  timeForSpawn: 1000

    Image
    {
        id:bg;
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/design/game2/qt_game2.png"
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
    PropertyAnimation {id: canvasAnim; target: canvas; properties: "opacity"; to: "0"; duration: 500;
        onStopped:
        {
            timerOut.start();
        }}


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
        if(++killCont >= numToKill)
        {
            timer.running = false;
            canvasAnim.start();
        }
    }

    Timer
    {
        id:timerOut;
        interval: timeForFinish;
        running: false;
        repeat: false;
        onTriggered:
        {
            finish();
        }
    }

    Timer
    {
        id:timerForStart;
        interval: timeForStart;
        running: false;
        repeat: false;
        onTriggered:
        {
            opacityAnim.start();
            promt.show(gameId);
            timer.running = true;
        }
    }

    Timer
    {
        id:timer;
        interval: timeForSpawn;
        running: false;
        repeat: true;
        onTriggered:
        {
            spawnObjects();
        }
    }
}
