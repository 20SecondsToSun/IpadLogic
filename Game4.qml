import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:root
    signal gameFinished(int id);

    Rectangle
    {
        width:root.width;
        height:root.height;
        color:"yellow";
    }

    function clean()
    {
       console.log("clean---------");
    }

    function start()
    {

    }
}
