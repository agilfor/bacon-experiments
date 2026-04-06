import QtQuick
import QtQuick.Controls

Window {
    width: 1080
    height: 1920
    visible: true
    color: "#1e1e1e" // Dark gray background

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
                // Later, we'll hook this up to C++ to run your bash script!
            }
        }
    }
}