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

    function start()
    {
        console.log("start gyro---------");
        gyro.start();
    }

    Text
    {
       //text: "Gyro values: "
       font.family: "Helvetica"
       font.pointSize: 24
       color: "red"
       id:gyroValues;
       anchors.centerIn: parent;
       text: "X Rotation: " + tilt.reading.xRotation.toFixed(2) + " Y Rotation: " + tilt.reading.yRotation.toFixed(2) ;//+ " Z Rotation: " + tilt.reading.zRotation.toFixed(2);
    }

    TiltSensor {
        id: tilt
        active: true
    }

}
