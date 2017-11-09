import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:root

    signal gameFinished(int id);
    property int gameId: 6;

    Button {
           width:400;
           height:400;
           anchors.horizontalCenter: root.horizontalCenter
           anchors.verticalCenter: root.verticalCenter
           opacity:0.2
           onClicked:
           {
               root.gameFinished(gameId)
           }
       }

    function clean()
    {
       console.log("clean---------");
    }
    function start()
    {

    }
}
