import QtQuick 2.0
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

Item {
    id:root
    signal gameFinished(int id);

    property int slidesNum: 8;
    property var colors:
        [
        {c1:"#f38917", c2: "#dd6513", c3: "#a33409"},
        {c1:"#fb619d", c2: "#ed4486", c3: "#ad2e57"},
        {c1:"#21d161", c2: "#01a53d", c3: "#076f2c"},
        {c1:"#d143c6", c2: "#a32b9a", c3: "#63125e"},
        {c1:"#f6f1d0", c2: "#f4eeca", c3: "#b3af96"},
        {c1:"#f64146", c2: "#da2c31", c3: "#971619"},
        {c1:"#bb2655", c2: "#961a41", c3: "#65122c"},
        {c1:"#f38917", c2: "#dd6513", c3: "#a33409"}
    ];

    function clean()
    {

    }

    function start()
    {

    }

    PropertyAnimation {id: colorAnim1; target: color1; easing.type: Easing.Linear; properties: "color"; to: "0"; duration: 500}
    PropertyAnimation {id: colorAnim2; target: color2; easing.type: Easing.Linear; properties: "color"; to: "0"; duration: 500}
    PropertyAnimation {id: colorAnim3; target: color3; easing.type: Easing.Linear; properties: "color"; to: "0"; duration: 500}

    Rectangle
    {
        id:bg
        width:root.width;
        height:root.height;
        color: colors[0];

        LinearGradient {
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(0, root.height)
                gradient: Gradient {
                    GradientStop { id:color1; position: 0.0; color: "#f38917" }
                    GradientStop { id:color2; position: 0.5; color: "#dd6513" }
                    GradientStop { id:color3; position: 1.0; color: "#a33409" }
                }
            }
    }

    SwipeView {
        id: view
        currentIndex: 0
        anchors.fill: parent

        Repeater {
               model: slidesNum
               Image {
                   fillMode: Image.PreserveAspectFit
                   source: "qrc:/images/design/slides/slide" + (index + 1) + ".png"
                   asynchronous: true;
                   width:root.width;
               }
           }

        onCurrentItemChanged:
        {
               colorAnim1.to = colors[currentIndex].c1;
               colorAnim2.to = colors[currentIndex].c2;
               colorAnim3.to = colors[currentIndex].c3;

               colorAnim1.start();
               colorAnim2.start();
               colorAnim3.start();

               if(slidesNum == currentIndex + 1)
               {
                   gameFinished(5);
               }
            }
    }
}
