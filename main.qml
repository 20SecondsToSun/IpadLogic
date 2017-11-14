import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    visible: true
    width: 1024
    height: 768
    title: qsTr("LogicIpad")

    property bool canInteract:false;
    property int currentLocation: 0;
    property bool wasSleep:false;

    property int introLocationID:0;
    property int finalLocationID:7;

    property var model :
        [
        {name:"Intro.qml", timecode: 1300, seek: -1},
        {name:"Game1.qml", timecode: 5300, seek: -1},
        {name:"Game2.qml", timecode: 9100, seek: -1},
        {name:"Game3.qml", timecode: 16800, seek: -1},
        {name:"Game4.qml", timecode: 19000, seek: -1},
        {name:"SliderLocation.qml", timecode: 24000, seek: -1},
        {name:"Final.qml", timecode: 27000, seek: -1},
        {name:"", timecode: 30000, seek: -1}
    ];

    Connections {
        target: Qt.application
        onStateChanged: {
            if(Qt.application.state === Qt.ApplicationActive)
            {
                if(wasSleep && currentLocation == introLocationID)
                {
                    wasSleep = false;
                    pageLoader.item.clean();
                    start();
                }
            }
            else
            {
                wasSleep = true;
            }
        }
    }

    Connections
    {
        target: pageLoader.item
        onGameFinished: nextLocation(id+1);
        onStartFinishing:
        {
            playVideo();
        }
    }

    Component.onCompleted:
    {
        console.log("onCompleted");
    }

    Image
    {
        id:bg;
        fillMode: Image.PreserveAspectFit
        source:"qrc:/images/design/WhiteBGimg.png"
        width: sourceSize.width * tool.getScale();
    }

    Video
    {
        id:videoPlayer;
        onVideoPaused:
        {
            canInteract = true;
            if(currentLocation == finalLocationID)
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
        opacity:1.
    }

    function playVideo()
    {
        currentLocation++;
        console.log("currentLocation ----------  ", currentLocation);
        videoPlayer.seekTo(model[currentLocation].seek);
        videoPlayer.playTo(model[currentLocation].timecode);
        videoPlayer.visible = true;
        canInteract = false;
    }

    Menu
    {
        onSkipClick:
        {
            if(canInteract)
            {
                pageLoader.item.finish()
            }
        }

        onHomeClick:
        {
            if(canInteract && currentLocation != introLocationID)
            {
                start();
            }
        }
    }

    function start()
    {
        currentLocation = introLocationID;
        videoPlayer.init(model[currentLocation].timecode);
        videoPlayer.visible = true;
        pageLoader.source = model[currentLocation].name;
        canInteract = false;
        pageLoader.item.start();
    }

    function nextLocation(id)
    {
        currentLocation = id;
        canInteract = false;

        pageLoader.item.clean();

        if(id === introLocationID)
        {
            start();
        }
        else if(model[currentLocation].name !== "")
        {
            pageLoader.source = model[currentLocation].name;
        }

        pageLoader.item.start();
    }

    Tools
    {
        id:tool
    }
}
