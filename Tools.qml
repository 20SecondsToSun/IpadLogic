import QtQuick 2.0

Item {

    function getScale()
    {
        return 0.5;
    }

    function getRand(min, max)
    {
      return Math.random() * (max - min) + min;
    }

    function getRandInt(min, max)
    {
      return Math.floor(Math.random() * (max - min)) + min;
    }

    function clamp(num, min, max)
    {
      return num <= min ? min : num >= max ? max : num;
    }

    function  map(value, in_min, in_max, out_min, out_max)
    {
      return (value - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
    }
}
