import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:root

     property int gameId: 0;
     signal gameFinished(int id);
     signal startFinishing();

     property int timeForStart:1100;

    Image
    {
        id:bg;
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/design/qt_intro.png"
        width: root.width
        opacity:0;
    }

    PropertyAnimation {id: opacityAnim; target: bg; properties: "opacity"; to: "1"; duration: 500}

    Button
    {
       onClicked: root.finish()
       x:100;
       y:200;
       width:200;
       height:200;
       anchors.horizontalCenter: root.horizontalCenter
       anchors.verticalCenter: root.verticalCenter
       anchors.verticalCenterOffset: 250;
       opacity:0
    }

    function clean()
    {
       timerForStart.running = false;
       bg.opacity = 0;
    }

    function start()
    {
        console.log("INTRO START");
        timerForStart.running = true;

    }

    function finish()
    {
        root.startFinishing()
        root.gameFinished(gameId);
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
        }
    }
}
