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
    property bool needLoading:false;

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
           // console.log("state   ", Qt.application.state);
            if(Qt.application.state === Qt.ApplicationActive)
            {
               // console.log("active   ", currentLocation, videoPlayer.printPosition());
                if(wasSleep)// && currentLocation != 0)
                {
                    if(currentLocation == 0)
                        waitTimer.running = true;

                    wasSleep = false;
                    pageLoader.item.clean();
                    start();

                    if(currentLocation == 0)
                         needLoading = false;


                }
            }
            else if(Qt.application.state === 0)
            {
                //console.log("sleep   ", currentLocation, videoPlayer.printPosition());
                //if(currentLocation != 0)
                {
                    videoPlayer.pause();
                    wasSleep = true;
                }
            }
        }
    }

    Timer
    {
        id:waitTimer;
        interval: 1500;
        running: false;
        repeat: false;
        onTriggered:
        {
            videoPlayer.init(model[0].timecode);
            videoPlayer.visible = true;
            pageLoader.item.start();
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
        onLoaded:
        {
            console.log("Loaded ....... LOCATION")
            if(needLoading)
            {
                needLoading = false;
                videoPlayer.init(model[0].timecode);
                videoPlayer.visible = true;
                pageLoader.item.start();
            }
        }
    }

    function playVideo()
    {
        currentLocation++;
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
        needLoading = true;
        currentLocation = introLocationID;
        pageLoader.source = model[currentLocation].name;
        canInteract = false;
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
