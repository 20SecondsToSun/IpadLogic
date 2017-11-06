import QtQuick 2.0
import QtQuick.Controls 2.0

Item {

    id:root;
    signal skipClick;
    signal homeClick;

    Row{
    Button {
           text: "home"
           onClicked: root.homeClick()
       }
    Button {
           text: "skip"
           onClicked: root.skipClick()
       }
    }
}
