import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtSensors 5.0

ApplicationWindow {
    title: qsTr("Hello World")
    width: 640
    height: 480
    visible: true

    SensorGesture {
        id: sensorGesture
        enabled: true
        gestures : ["QtSensors.shake", "QtSensors.shake2"]
        onDetected: {
            console.debug(gesture)
        }
    }

}
