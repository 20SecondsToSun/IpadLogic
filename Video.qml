import QtQuick 2.0
import QtMultimedia 5.8

Item {
    id:root;
    signal videoPaused;
    signal videoLoaded;
    property int seqNum:0;

    Component.onCompleted:
    {
        console.log("video loaded");
        preInitTimer.running = true;
    }

    Timer
    {
        id:preInitTimer;
        interval: 1000;
        running: false;
        repeat: false;
        onTriggered:
        {
          root.videoLoaded();
        }
    }

    MediaPlayer {
            id: video
            source: "qrc:/images/design/mainvid.mp4"
        }

    VideoOutput {
          source: video
          width:1024
          height : 768
          opacity:1.

      }

    function init(ms)
    {
       video.seek(0);
       timer.running = true;

       timer.interval = (ms);
       video.play();
    }

    function seekTo(ms)
    {
       if(ms === -1)
            return;


        video.pause();
        video.seek(ms);
    }

    function playTo(ms)
    {
       // console.log("ms  "+ ms,"position: "+ video.position);
        if(ms - video.position > 0)
        {
            timer.running = true;
            timer.interval = ms - video.position;
            console.log("timer.interval  " + timer.interval);
            video.play();
        }
    }

    Timer {
            id:timer;
            running: false;
            repeat: false
            onTriggered:
            {
                video.pause();
                root.videoPaused();
                console.log("stoped  ","position: "+ video.position);
            }
        }
}
