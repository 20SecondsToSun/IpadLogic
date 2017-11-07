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
         {name:"qrc:/images/design/promts/promt5.png", x: 100, y :200},
         {name:"", x: 100, y :200}
    ];

    Image
    {
        id:promt;
        fillMode: Image.PreserveAspectFit
        width:300;
    }

    PropertyAnimation {id: inAnimation; target: promt; properties: "opacity"; to: "1"; duration: 1000}
    PropertyAnimation {id: outAnimation; target: promt; properties: "opacity"; to: "0"; duration: 100}


    function hide()
    {
        timer.running = false;
        //root.visible = false;
        outAnimation.start();
    }

    function show(id)
    {
       if(model[id].name !== "")
       {
           promt.opacity = 0;
           promt.x = model[id].x;
           promt.y = model[id].y;
           promt.source = model[id].name;
           root.visible = true;
           timer.running = true;
           inAnimation.start();
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
          hide();
        }
    }
}

