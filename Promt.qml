import QtQuick 2.0
import QtQuick.Controls 2.0

Item
{
    id:root;
    visible:false;

    property int timeToHide: 7000;

    property var model :
        [
         {name:"", x: 100, y :200},
         {name:"qrc:/images/design/promts/promt1.png", x: 1206, y :409},
         {name:"qrc:/images/design/promts/promt2.png", x: 1472, y :892},
         {name:"qrc:/images/design/promts/promt3.png", x: 924,  y :848},
         {name:"qrc:/images/design/promts/promt4.png", x: 1351, y :698},
         {name:"qrc:/images/design/promts/promt5.png", x: 840,  y :1235},
         {name:"", x: 100, y :200}
    ];

    Image
    {
        id:promt;
        fillMode: Image.PreserveAspectFit
        width: sourceSize.width * tool.getScale();
    }

    PropertyAnimation {id: inAnimation; target: promt; properties: "opacity"; to: "1"; duration: 1000}
    PropertyAnimation {id: outAnimation; target: promt; properties: "opacity"; to: "0"; duration: 100}


    function hide()
    {
        timer.running = false;
        outAnimation.start();
    }

    function show(id)
    {
       if(model[id].name !== "")
       {
           promt.opacity = 0;
           promt.x = model[id].x* tool.getScale();
           promt.y = model[id].y* tool.getScale();
           promt.source = model[id].name;
           root.visible = true;
           timer.running = true;
           inAnimation.start();
       }
    }

    Timer
    {
        id:timer;
        interval: timeToHide;
        running: false;
        repeat: false
        onTriggered:
        {
          hide();
        }
    }

    Tools{
        id:tool;
    }
}

