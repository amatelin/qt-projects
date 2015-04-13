import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtSensors 5.1
import QtSensors 5.1 as Sensors
import QtMultimedia 5.0
import "voiceOver.js" as VoiceOver

ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true

    property int compliment_i: 14


    property string state: "listening"
    property real baseCoeff: 1.5

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.debug("Yay");
            accelero.active = !accelero.active;
            console.debug(accelero.active);
        }
    }

    Accelerometer {
        id: accelero
        active: true
        onReadingChanged: {
                var y_delta = getCleanValue()
                if (y_delta<=baseCoeff*5) {
//                    VoiceOver.playIdle();
//                    console.debug("IDLE")
                } else if (y_delta>baseCoeff*5&y_delta<=baseCoeff*15) {
//                    console.debug("SLOW")
                    VoiceOver.playSlow();
                } else if (y_delta>baseCoeff*15&y_delta<=baseCoeff*25) {
//                    console.debug("MEDIUM")
//                    VoiceOver.playMedium();
                } else if (y_delta>baseCoeff*25&y_delta<baseCoeff*35) {
//                    console.debug("FAST")
//                    VoiceOver.playFast();
                } else if (y_delta>=baseCoeff*35) {
//                    VoiceOver.playVeryFast();
                }
            }


        function getCleanValue() {
            return Math.round(Math.abs(reading.y))
        }
    }

    Timer {
        id: timer
        running: false
        repeat: false
        interval: 100
        onTriggered: {
            console.debug("d")
            window.state = "listening"
        }
    }

}
