import QtQuick 2.0
import QtQuick.Controls 2.0
import QtSensors 5.0

Item {
    id:root
    signal gameFinished(int id);

    Rectangle
    {
        width:root.width;
        height:root.height;
        color:"white";
    }

    function clean()
    {
       console.log("clean---------");
    }

    Text
    {
       text: "Gyro values: "
       font.family: "Helvetica"
       font.pointSize: 24
       color: "red"
       id:gyroValues;
       anchors.centerIn: parent;
    }

    Gyroscope
    {
        id: gyro
        active: true
        alwaysOn: true

        onReadingChanged:
        {
            gyroValues.text = "x: " + reading.x + " y: " + reading.y + " z: " + reading.z;
        }
    }
}
