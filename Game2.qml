import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:root
    signal gameFinished(int id);

    Image {
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/design/game2.jpg"
        width:root.width;
    }

    function clean()
    {
       console.log("clean---------");
    }
}
