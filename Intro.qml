import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:root

     property int gameId: 0;
     signal gameFinished(int id);
     signal startFinishing();

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
       console.log("clean---------");
    }

    function start()
    {

    }

    function finish()
    {
        root.startFinishing()
        root.gameFinished(gameId);
    }
}
