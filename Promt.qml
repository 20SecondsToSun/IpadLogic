import QtQuick 2.0
import QtQuick.Controls 2.0

Item
{
    id:root;
    visible:false;

    property var model :
        [
         {name:"", x: 100, y :200},
         {name:"qrc:/images/design/promts/promt1.png", x: 100, y :200},
         {name:"qrc:/images/design/promts/promt2.png", x: 150, y :250},
         {name:"qrc:/images/design/promts/promt3.png", x: 300, y :400},
         {name:"qrc:/images/design/promts/promt4.png", x: 100, y :200},
         {name:"qrc:/images/design/promts/promt5.png", x: 100, y :200}
    ];

    Image
    {
        id:promt;
        fillMode: Image.PreserveAspectFit
        width:300;
    }

    function hide()
    {
        timer.running = false;
        root.visible = false;
    }

    function show(id)
    {
       if(model[id].name !== "")
       {
           promt.x = model[id].x;
           promt.y = model[id].y;
           promt.source = model[id].name;
           root.visible = true;
           timer.running = true;
       }
    }

    Timer
    {
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

