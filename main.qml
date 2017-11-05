import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    visible: true
    width: 1024
    height: 768
    title: qsTr("LogicIpad")
   Loader {
       id: pageLoader
       source: "Game1.qml"
   }

   Connections {
          target: pageLoader.item
          onGame1Finished: pageLoader.source = "Game2.qml"
          onGame2Finished: pageLoader.source = "Game3.qml"
      }

    Video
    {
        id:videoPlayer;
    }

    Menu
    {
        onSkipClick:
        {
            videoPlayer.playTo(1500);
        }

        onHomeClick:
        {

        }
    }



}
