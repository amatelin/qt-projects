import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    title: qsTr("Accelerate Bubble")
    id: mainWindow
    width: 640
    height: 480
    visible: true

    Image {
        id: bubble
        source: "Bluebubble.svg"
        smooth: true
        property real centerX: mainWindow.width / 2
        property real centerY: mainWindow.height / 2
        property real bubbleCenter: bubble.width / 2
        x: centerX - bubbleCenter
        y: centerY - bubbleCenter
    }

}
