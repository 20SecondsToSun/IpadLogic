import QtQuick 2.0
import QtMultimedia 5.8

Item {

    Video {
        id: video
        width : 1024
        height : 768
        source: "qrc:/design/video.mp4"
        opacity:0.4
    }

    function playTo(ms)
    {
        if(ms - video.position > 0)
        {
            timer.running = true;
            timer.interval = ms - video.position;
            video.play();
        }
    }

    Timer {
            id:timer;
            interval: 1500;
            running: false;
            repeat: false
            onTriggered: video.pause()
        }
}
