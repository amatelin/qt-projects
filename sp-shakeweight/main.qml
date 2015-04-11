import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtSensors 5.1
import QtSensors 5.1 as Sensors
import QtMultimedia 5.0

ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true


    property string state: "listening"
    property int baseCoeff: 1

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.debug("Yay")
        }
    }

    Accelerometer {
        id: accelero
        active: true
        onReadingChanged: {
                var y_delta = getCleanValue()
                if (y_delta<=baseCoeff) {
                    console.debug("IDLE")
                } else if (y_delta>baseCoeff&y_delta<=baseCoeff*12.5) {
                    console.debug("SLOW")
                } else if (y_delta>baseCoeff*12.5) {
                    console.debug("FAST")
                }
            }

        function getCleanValue() {
            return Math.round(Math.abs(reading.y))
        }
    }







}
