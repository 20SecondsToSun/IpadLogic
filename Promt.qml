import QtQuick 2.0
import QtQuick.Controls 2.0

Item
{
    id:root;
    visible:false;

    property var model :
        [
         {name:"qrc:/images/design/promt1.jpg", x: 100, y :200},
         {name:"qrc:/images/design/promt1.jpg", x: 150, y :250},
         {name:"qrc:/images/design/promt1.jpg", x: 100, y :200},
         {name:"qrc:/images/design/promt1.jpg", x: 100, y :200}
    ];

    Rectangle
    {
        id:promt;
        width:200;
        height:300;
        color:"yellow";
    }

    function hide()
    {
        timer.running = false;
         root.visible = false;
    }

    function show(id)
    {
        promt.x = model[id].x;
        promt.y = model[id].y;
        root.visible = true;
        timer.running = true;
    }

    Timer {
            id:timer;
            interval: 3000;
            running: false;
            repeat: false
            onTriggered:
            {
               root.visible = false;
            }
        }
}

