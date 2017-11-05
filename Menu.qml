import QtQuick 2.0
import QtQuick.Controls 2.0

Item {

    id:root;
    signal skipClick;
    signal homeClick;

    Button {
           text: "Ok"
           onClicked: root.skipClick()
       }
}
