import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:root
    signal gameFinished(int id);

    property int slidesNum:4;

    function clean()
    {
       console.log("clean---------");
    }

    SwipeView {
        id: view
        currentIndex: 0
        anchors.fill: parent

        Repeater {
               model: slidesNum
               Image {
                   fillMode: Image.PreserveAspectFit
                   source: "qrc:/images/design/slides/slide"+(index+1)+".png"
                   width:root.width;
               }
           }

        onCurrentItemChanged: {

               if(slidesNum == currentIndex + 1)
               {
                   gameFinished(5);
               }
            }
    }


}
