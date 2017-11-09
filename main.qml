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

    property var model :
    [
            {name:"Intro.qml", timecode: 1300, seek: -1},
            {name:"Game1.qml", timecode: 6100, seek: -1},
            {name:"Game2.qml", timecode: 9100, seek: -1},
            {name:"Game3.qml", timecode: 15800, seek: -1},
            {name:"Game4.qml", timecode: 18400, seek: -1},
            {name:"SliderLocation.qml", timecode: 23000, seek: -1},
            {name:"Final.qml", timecode: 27000, seek: -1},
            {name:"", timecode: 29000, seek: -1}
    ];

    Connections {
       target: Qt.application
       onStateChanged: {
          if(Qt.application.state === Qt.ApplicationActive)
          {
              if(wasSleep && currentLocation == 0)
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

    function playVideo()
    {
        currentLocation++;
        console.log("currentLocation ----------  ", currentLocation);
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
               ///nextLocation(currentLocation + 1);
                pageLoader.item.finish()
            }
        }

        onHomeClick:
        {
            if(canInteract && currentLocation != 0)
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
                console.log(" start location  ", model[currentLocation].name);
                pageLoader.source = model[currentLocation].name;
            }

           //videoPlayer.seekTo(model[currentLocation].seek);
            //videoPlayer.playTo(model[currentLocation].timecode);
           // videoPlayer.visible = true;
        }

        pageLoader.item.start();
    }

    Tools
    {
        id:tool
    }
}
