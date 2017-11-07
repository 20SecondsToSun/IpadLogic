import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:root
    signal gameFinished(int id);

    Image
    {
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/design/1.png"
        width:root.width;
        anchors.horizontalCenter: parent;
        anchors.bottom: parent.bottom;
        anchors.baselineOffset: 100;
    }

    Button
    {
       text: "Next"
       onClicked: root.gameFinished(0)
       x:300;
       y:200;
       anchors.centerIn: parent;
    }

    function clean()
    {
       console.log("clean---------");
    }
}
