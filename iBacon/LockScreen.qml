import QtQuick
import QtQuick.Window

Window {
    id: lockWindow
    width: Screen.width
    height: Screen.height
    visible: true
    title: "iBaconLock" // We will use this title to tell Sway where to put it

    // Dark gradient background
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#2c3e50" }
            GradientStop { position: 1.0; color: "#000000" }
        }
    }

    // iOS Clock and Date
    Item {
        anchors.top: parent.top
        anchors.topMargin: 100
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: 200

        Text {
            id: timeText
            anchors.horizontalCenter: parent.horizontalCenter
            text: Qt.formatDateTime(new Date(), "hh:mm")
            font.pixelSize: 110
            font.bold: true
            color: "white"
        }
        Text {
            id: dateText
            anchors.top: timeText.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: Qt.formatDateTime(new Date(), "dddd, MMMM d")
            font.pixelSize: 24
            color: "white"
        }
    }

    // Ticks every second to keep the clock alive
    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: {
            timeText.text = Qt.formatDateTime(new Date(), "hh:mm")
            dateText.text = Qt.formatDateTime(new Date(), "dddd, MMMM d")
        }
    }

    // Unlock hint
    Text {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Swipe up to unlock"
        font.pixelSize: 20
        color: "#88ffffff"
        font.bold: true
    }
}