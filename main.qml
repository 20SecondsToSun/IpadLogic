import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    visible: true
    width: 1024
    height: 768
    title: qsTr("LogicIpad")

    property bool canInteract:false;
    property int currentLocation: 0;

    property var model :
    [
            {name:"Intro.qml", timecode: 1500},
            {name:"Game1.qml", timecode: 3500},
            {name:"Game2.qml", timecode: 4500},
            {name:"Game3.qml", timecode: 5500},
            {name:"Game4.qml", timecode: 6500},
            {name:"SliderLocation.qml", timecode: 8500},
            {name:"Final.qml", timecode: 9500},
            {name:"", timecode: 11500}
    ];

    Connections
    {
       target: pageLoader.item
       onGameFinished: nextLocation(id+1);
    }

    Component.onCompleted: start();

    Loader
    {
       id: pageLoader
       width:parent.width;
       height:parent.height;
    }

    Video
    {
        id:videoPlayer;
        onVideoPaused:
        {
            canInteract = true;
            if(currentLocation == 1 || currentLocation == 5)
            {
                videoPlayer.visible = false;
            }

            if(currentLocation == 7)
            {
                start();
            }

            promt.show(currentLocation);

        }
    }

    Promt
    {
        id:promt
    }

    Menu
    {
        onSkipClick:
        {
            if(canInteract)
            {
               nextLocation(currentLocation + 1);
            }
        }

        onHomeClick:
        {
            if(canInteract)
            {
                start();
            }
        }
    }

    function start()
    {
        currentLocation = 0;
        videoPlayer.init(model[currentLocation].timecode);
        videoPlayer.visible = true;
        pageLoader.source = model[currentLocation].name;
        canInteract = false;
        promt.hide();
    }

    function nextLocation(id)
    {
        if(!canInteract)
        {
            return;
        }

        currentLocation = id;
        canInteract = false;

        pageLoader.item.clean();
        promt.hide();

        if(id === 0)
        {
            start();
        }
        else
        {
            if(model[currentLocation].name !== "")
            {
                pageLoader.source = model[currentLocation].name;
            }

            videoPlayer.playTo(model[currentLocation].timecode);
            videoPlayer.visible = true;
        }

        pageLoader.item.start();
    }
}
