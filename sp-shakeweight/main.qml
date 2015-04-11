import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtSensors 5.0
import QtSensors 5.0 as Sensors
import QtMultimedia 5.0

ApplicationWindow {
    width: 640
    height: 480
    visible: true

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.debug("Yay")
        }
    }

    Audio {
        id: voice1
        source: "content/audio/audio1.wav"
    }

   /* SensorGesture {
        id: sensorGesture
        enabled: true
        gestures : ["QtSensors.shake"]
        onDetected: {
            console.debug(gesture)
            voice1.play()

            var types = Sensors.QmlSensors.sensorTypes();
            console.log(types.join(", "));
        }
    }*/

    MainForm {
        anchors.fill: parent
        button1.onClicked: accel.active=!accel.active
        button2.onClicked: gyro.active=!gyro.active
        button3.onClicked: orient.active=!orient.active
        button4.onClicked: rot.active=!rot.active
        button5.onClicked: tilt.active=!tilt.active

    }

    Accelerometer {
        id: accel

        onReadingChanged: {
            var readings = roundReadings([reading.x, reading.y, reading.z])
            console.debug(readings)
        }

    }

    Gyroscope {
        id: gyro
        onReadingChanged: {
            var readings = roundReadings([reading.x, reading.y, reading.z])
            console.debug(readings)
        }
    }

    OrientationSensor {
        id: orient
        onReadingChanged: {
            console.debug(roundReadings([reading.orientation]))
        }
    }

    RotationSensor {
        id: rot
        onReadingChanged: {
            var readings = roundReadings([reading.x, reading.y, reading.z])
            console.debug(readings)
        }
    }

    TiltSensor {
        id: tilt
        onReadingChanged: {
            var readings = roundReadings([reading.xRotation, reading.yRotation])
            console.debug(readings)
        }
    }

    function roundReadings(array_in){
        var array_out = []
        for (var i=0; i<array_in.length; i++){
            array_out.push(Math.round(array_in[i]*100)/100)
        }
        return array_out
    }

}
