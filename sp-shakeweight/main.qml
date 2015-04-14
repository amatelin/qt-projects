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
    visibility: Window.FullScreen

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
                timer0.running = false;
                accelero.active = false;
                VoiceOver.player.stop();
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
                if (y_delta>0&y_delta<=baseCoeff) {
                    VoiceOver.playIdle();
                } else if (y_delta>baseCoeff*5&y_delta<=baseCoeff*15) {
                    VoiceOver.playSlow();
                } else if (y_delta>baseCoeff*15&y_delta<=baseCoeff*25) {
                    VoiceOver.playMedium();
                } else if (y_delta>baseCoeff*25&y_delta<baseCoeff*35) {
                    VoiceOver.playFast();
                } else if (y_delta>=baseCoeff*35) {
                    VoiceOver.playVeryFast();
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
        id: timer0
        interval: 50
        running: false

        onTriggered: {
            if (VoiceOver.player.playing) {
                accelero.active = false;
                timer0.start();
            }
            else {
                 accelero.active = true;
                }
        }
    }

    Timer {
        id: timer1
        interval: 15
        running: false

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
        running: false

        onTriggered: {
            if (VoiceOver.player.playing)
                timer2.start();
            else {
                screenManager.state = "menu"
             }
        }
    }


}
