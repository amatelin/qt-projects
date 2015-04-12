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
                    //voiceOver.playQuicky()
                } else if (y_delta>baseCoeff&y_delta<=baseCoeff*12.5) {
                    voiceOver.playGood()
//                    console.debug("SLOW")
                } else if (y_delta>baseCoeff*12.5&y_delta<=baseCoeff*20) {
                    playAlmost()
                    console.debug("MEDIUM")
                } else if (y_delta>baseCoeff*20) {
                    console.debug("FAST")
                    playCompliment()
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
        onTriggered: {
            window.state = "listening"
        }
    }

    Audio {
        id: voiceOver
        property int almost_i: 2
        property int compliment_i: 14
        property int end_i: 5
        property int fingers_i: 2
        property int good_i: 4
        property int keep_i: 3
        property int more_i: 4
        property int motivation_i: 7
        property int quicky_i: 1
        property int yes_i: 4

        function playSomething(name, length)
        {
            if (length>1&window.state==="listening")
            {
                source = "content/audio/" + name + "/" + pad(length, 3) + ".wav"
                timer.interval = duration
                window.state = "playing"
                play()
                timer.start()
                length-=1
            }
        }

        function playAlmost(){
            playSomething("almost", almost_i)
        }

        function playCompliment(){
            playSomething("compliment", compliment_i)
        }

        function playEnd(){

        }

        function playFinger(){

        }
        function playGood(){

        }
        function playKeep(){

        }
        function playMore(){

        }
        function playMotivation(){

        }
        function playQuicky(){

        }
        function playYes(){

        }
    }



    function pad(n, width, z) {
      z = z || '0';
      n = n + '';
      return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
    }



}
