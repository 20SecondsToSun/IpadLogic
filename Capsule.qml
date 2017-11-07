import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
     id:root
     property int size;
     property variant _parent;

    Image
    {
        id:promt;
        fillMode: Image.PreserveAspectFit
        width:200;
        source:"qrc:/images/design/Capsule.png"
        Button
        {
            width:promt.width;
            height:promt.height;
            opacity: 0;
            onClicked:
            {
                _parent.onKilled()
                root.destroy();
            }
        }
    }



    Timer
    {
        id:timer;
        interval: 2000;
        running: true;
        repeat: false;
        onTriggered:
        {
          root.destroy();
        }
    }
}
