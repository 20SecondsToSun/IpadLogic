import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:root
    signal gameFinished(int id);


    Button {
           text: "GoHome"
           onClicked: root.gameFinished(6)
           x:300;
           y:200;
           anchors.centerIn: parent;
       }

    function clean()
    {
       console.log("clean---------");
    }
    function start()
    {

    }
}
