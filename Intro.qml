import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:root
    signal gameFinished(int id);

    Rectangle
    {
        width:root.width;
        height:root.height;
        color:"white";
    }

    Button
    {
       text: "Next"
       onClicked: root.gameFinished(0)
       x:300;
       y:200;
       //anchors.centerIn: parent;
    }

    function clean()
    {
       console.log("clean---------");
    }

    function start()
    {

    }
}
