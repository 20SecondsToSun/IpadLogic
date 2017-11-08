import QtQuick 2.0
import QtQuick.Controls 2.0
import QtSensors 5.0

Item {
    id:root

    width:parent.width;
    height:parent.height;

    signal gameFinished(int id);

    property int yFinished: 630;

    Rectangle
    {
        width:root.width;
        height:root.height;
        color:"blue";
    }

    Image
    {
        id:splash;
        fillMode: Image.PreserveAspectFit
        width:root.width;
        source:"qrc:/images/design/game3/Check2.png"
    }


    Image
    {
        id:fluid;
        fillMode: Image.PreserveAspectFit
        x:750;
        y:300;
        source:"qrc:/images/design/game3/Fluid1.png"
        transform: Rotation {id: fluidRot; origin.x: fluid.width * 0.5; origin.y: 0; angle: 0}
    }

    PropertyAnimation {id: rotAnim; target: fluidRot; properties: "angle"; to: "1"; duration: 300}
    PropertyAnimation {id: yAnim; target: fluid; properties: "y"; to: "1"; duration: 300}


    Button
    {
      x: 300;
      y: 300;
      text: "rot"
      onClicked:
      {


      }
    }

    function clean()
    {

    }

    function start()
    {
        tilt.active = true;
    }

    TiltSensor {
        id: tilt
        active: false;

        onReadingChanged:
        {
            var xRot = tilt.reading.xRotation.toFixed(2);

            if(xRot > 10)
            {
                rotAnim.to = xRot;
                rotAnim.start();
                yAnim.to = fluid.y + 10;
                yAnim.start();
            }
            else if(xRot < -10 )
            {
                rotAnim.to = xRot;
                rotAnim.start();
                yAnim.to = fluid.y + 10;
                yAnim.start();
            }

            if(yAnim.to >= 640)
            {
                gameFinished(3);
            }

        }
    }
}
