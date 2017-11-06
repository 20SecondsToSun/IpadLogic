import QtQuick 2.0
import QtMultimedia 5.8

Item {
    id:root;
    signal videoPaused;

    Video {
        id: video
        width : 1024
        height : 768
        source: "qrc:/images/design/video.mp4"
        opacity:0.4
    }

    function init(ms)
    {
        video.seek(0);
        timer.running = true;
        timer.interval = (ms);
        video.play();
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
            onTriggered:
            {
                video.pause();
                root.videoPaused();
            }
        }
}
