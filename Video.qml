import QtQuick 2.0
import QtMultimedia 5.8

Item {
    id:root;
    signal videoPaused;
    property int seqNum:0;

//    Video {
//        id: video
//        width : 1024
//        height : 768
//        source: "qrc:/images/design/video.mp4"
//        opacity:0.4
//    }

    MediaPlayer {
            id: video

            source: "qrc:/images/design/logic2.mp4"
        }

    VideoOutput {
         // anchors.fill: parent
          source: video
          width:1024
          height : 768
          opacity:0.4
      }

//    Image
//    {
//       id:vidseq;
//       source: "qrc:/images/design/jpgSequnce/logic010.jpg"
//       fillMode: Image.PreserveAspectFit
//       width:1024
//    }

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
            console.log("timer.interval  " + timer.interval);
            video.play();
        }
    }

    Timer {
            id:timer;
            interval: 1000/60;
            running: false;
            repeat: false
            onTriggered:
            {
                console.log("video finished");
//                var start = "qrc:/images/design/jpgSequnce/logic";
//                seqNum++;
//                if(seqNum >= 520) seqNum = 0;
//                if(seqNum < 10) start += "00";
//                else if(seqNum < 100) start+="0";
//                 start+=seqNum;

//                vidseq.source = start + ".jpg";

                video.pause();
                root.videoPaused();
            }
        }
}
