import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtSensors 5.1
import QtSensors 5.1 as Sensors
import QtMultimedia 5.4
import "voiceOver.js" as VoiceOver


ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480

    property int compliment_i: 14
    property real baseCoeff: 1

    Image {
        id: screen1
        width: window.width
        height: window.height
        source: "content/img/menu01.png"
        visible: false

        onVisibleChanged: {
            if (visible) {
                accelero.active = false;
            }
        }

        MouseArea {
            id: mouseArea1
            x: 99
            y: 320
            anchors.bottomMargin: 23
            anchors.leftMargin: 99
            anchors.rightMargin: 336
            anchors.topMargin: 324
            anchors.fill: parent
            enabled: screen1.visible
            onClicked: {
                console.debug("Yay");
                screenManager.state = "game";
            }
            }
    }

    Image {
        id: screen2
        width: window.width
        height: window.height
        visible: false
        source: "content/img/game01.png"

        onVisibleChanged: {
            if (visible) {
                accelero.active = true;
            }
        }

        MouseArea {
            id: mouseArea2
            enabled: screen2.visible
            anchors.fill: parent

            onClicked: {
                screenManager.state = "menu";
            }
        }
    }

    Accelerometer {
        id: accelero
        active: false
        onReadingChanged: {
                var y_delta = getCleanValue()
                if (y_delta<=baseCoeff) {
                    VoiceOver.playIdle();
//                    console.debug("IDLE")
                } else if (y_delta>baseCoeff*5&y_delta<=baseCoeff*15) {
//                    console.debug("SLOW")
//                    VoiceOver.playSlow();
                } else if (y_delta>baseCoeff*15&y_delta<=baseCoeff*25) {
//                    console.debug("MEDIUM")
//                    VoiceOver.playMedium();
                } else if (y_delta>baseCoeff*25&y_delta<baseCoeff*35) {
//                    console.debug("FAST")
//                    VoiceOver.playFast();
                    VoiceOver.playCumSequence();
                } else if (y_delta>=baseCoeff*35) {
//                    VoiceOver.playVeryFast();
                }
            }


        function getCleanValue() {
            return Math.round(Math.abs(reading.y))
        }
    }




    StateGroup {
        id: screenManager
        state: "menu"
        states : [
            State {
                name: "menu"

                PropertyChanges {
                    target:screen1;
                    visible: true;
                }

                PropertyChanges {
                    target: screen2;
                    visible: false;
                }
            },
            State {
                name: "game"

                PropertyChanges {
                    target:screen1
                    visible: false;
                }

                PropertyChanges {
                    target: screen2
                    visible: true
                }
            }

        ]
    }

    Timer {
        id: timer1
        interval: 15

        onTriggered: {
            if (VoiceOver.player.playing) {
                timer1.start();
                accelero.active = false;
            }
            else {
                VoiceOver.player.source = VoiceOver.player.source2;
                VoiceOver.player.play();
                timer2.start()
                console.log(accelero.active);
             }
         }
    }
    Timer {
        id: timer2
        interval: 15

        onTriggered: {
            if (VoiceOver.player.playing)
                timer2.start();
            else {
                VoiceOver.player.source = VoiceOver.player.source3;
                VoiceOver.player.play();
                timer3.start();
             }
        }
    }
    Timer {
        id: timer3
        interval: 15

        onTriggered: {
            if (VoiceOver.player.playing)
                timer3.start();
            else {
                screenManager.state = "menu"
            }
        }
    }


}
