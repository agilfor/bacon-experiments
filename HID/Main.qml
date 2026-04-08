import QtQuick
import QtQuick.Controls

Window {
    id: root
    width: Screen.width
    height: Screen.height
    visible: true
    color: "#1e1e1e" // Dark gray background
    title: "HID-UI"

    Rectangle {
        anchors.centerIn: parent
        width: 600
        height: 200
        color: "#ff5555" // Red button
        radius: 30

        Text {
            anchors.centerIn: parent
            text: "FIRE PAYLOAD"
            color: "white"
            font.pixelSize: 50
            font.bold: true
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("Button tapped on screen!")
                Runner.fire()
            }
        }
    }
}