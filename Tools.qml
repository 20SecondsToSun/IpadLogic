import QtQuick 2.0

Item {

    function getScale()
    {
        return 0.5;
    }

    function getRand(min, max) {
      return Math.random() * (max - min) + min;
    }

    function getRandInt(min, max) {
      return Math.floor(Math.random() * (max - min)) + min;
    }
}
