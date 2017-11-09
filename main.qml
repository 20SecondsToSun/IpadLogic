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
            {name:"Intro.qml", timecode: 1200, seek: -1},
            {name:"Game1.qml", timecode: 5100, seek: -1},
            {name:"Game2.qml", timecode: 7100, seek: 5100},
            {name:"Game3.qml", timecode: 13700, seek: -1},
            {name:"Game4.qml", timecode: 16100, seek: -1},
            {name:"SliderLocation.qml", timecode: 21000, seek: -1},
            {name:"Final.qml", timecode: 25000, seek: 22000},
            {name:"", timecode: 27000, seek: -1}
    ];

    Connections
    {
       target: pageLoader.item
       onGameFinished: nextLocation(id+1);
    }

    Component.onCompleted:
    {
        console.log("onCompleted");
    }

    Video
    {
        id:videoPlayer;
        onVideoPaused:
        {
            canInteract = true;
            if(/*currentLocation == 1 || */currentLocation == 5)
            {
               // videoPlayer.visible = false;
            }

            if(currentLocation == 7)
            {
                start();
            }

        }

        onVideoLoaded:
        {
            start();
        }
    }

    Loader
    {
       id: pageLoader
       width:parent.width;
       height:parent.height;
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

            videoPlayer.seekTo(model[currentLocation].seek);
            videoPlayer.playTo(model[currentLocation].timecode);
            videoPlayer.visible = true;
        }

        pageLoader.item.start();
    }
}
