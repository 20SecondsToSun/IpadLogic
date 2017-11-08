import QtQuick 2.0
import QtQuick.Controls 2.0

Item {

    id:root;
    signal skipClick;
    signal homeClick;

    width:parent.width;
    height:parent.height;

    Image {
        id:homeimg
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/design/homeButton.png"
        asynchronous: true;
        anchors.top: root.top;
        anchors.right: root.right;
        anchors.rightMargin: 65* tool.getScale();
        anchors.topMargin: 65* tool.getScale();
        width: sourceSize.width * tool.getScale();
    }

    Button {
           onClicked: root.homeClick()
           anchors.top: root.top;
           anchors.right: root.right;
           anchors.rightMargin: 65* tool.getScale();
           anchors.topMargin: 65* tool.getScale();
           width:homeimg.width;
           height:homeimg.height;
           opacity:0;
       }
    Row{

    Button
    {
           width:200;
           height:200;
           opacity: 0.5;
           onClicked: root.skipClick();
       }
    }

    Tools{
        id:tool;
    }
}
