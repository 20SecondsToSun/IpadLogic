import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:root
    signal game2Finished;
    Image {
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/design/1.png"
    }

    Button {
           text: "Nextgame"
           onClicked: root.game2Finished()
           x:300;
           y:200;
       }
}
