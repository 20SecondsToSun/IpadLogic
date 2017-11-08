import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:root
    width:parent.width;
    height:parent.height;

     signal gameFinished(int id);

    Rectangle
    {
        width:root.width;
        height:root.height;
        color:"white";
    }

    Button
    {
       onClicked: root.gameFinished(0)
       x:100;
       y:200;
       width:200;
       height:200;
       anchors.horizontalCenter: root.horizontalCenter
       anchors.verticalCenter: root.verticalCenter
       anchors.verticalCenterOffset: 100;
    }

    function clean()
    {
       console.log("clean---------");
    }

    function start()
    {

    }
}
