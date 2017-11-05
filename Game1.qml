import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:root
    signal game1Finished;
    Image {
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/design/1.png"
    }

    Button {
           text: "Next"
           onClicked: root.game1Finished()
           x:300;
           y:200;
       }
}
