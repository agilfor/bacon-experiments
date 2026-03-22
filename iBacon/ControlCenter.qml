import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    id: ccWindow
    // 1. FILL THE ENTIRE SCREEN
    width: Screen.width
    height: Screen.height
    visible: true
    title: "ControlCenter"
    color: "transparent" 
    flags: Qt.FramelessWindowHint

    FontLoader {
        id: fa
        source: "file:///home/agilfor/bacon-experiments/iBacon/fontawesome.ttf" 
    }

    // 2. FULL-SCREEN TOUCH BLOCKER
    // This dims the SpringBoard and catches all touches so they don't fall through
    Rectangle {
        anchors.fill: parent
        color: "#80000000" // 50% opacity black

        MouseArea {
            anchors.fill: parent
            // Tap the empty space to close the Control Center!
            onClicked: System.closeControlCenter()
        }
    }

    // 3. THE ACTUAL TOP PANEL
    Rectangle {
        anchors.top: parent.top
        width: parent.width
        height: 380
        color: "#e61e1e1e" // Dark, mostly opaque glass

        // A subtle bottom border
        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width; height: 1
            color: "#33ffffff"
        }

        // --- TOP ROW: TOGGLE BUTTONS ---
        Row {
            anchors.top: parent.top; anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 30

            // Wi-Fi Button
            Rectangle {
                width: 70; height: 70; radius: 35; color: "#33ffffff"
                Text { anchors.centerIn: parent; text: "\uf1eb"; font.family: fa.name; font.pixelSize: 26; color: "white" }
                MouseArea { anchors.fill: parent; onClicked: { System.click(); System.toggleWifi(); parent.color = parent.color == "#33ffffff" ? "#0a84ff" : "#33ffffff" } }
            }

            // Bluetooth Button
            Rectangle {
                width: 70; height: 70; radius: 35; color: "#33ffffff"
                Text { anchors.centerIn: parent; text: "\uf293"; font.family: fa.name; font.pixelSize: 30; color: "white" }
                MouseArea { anchors.fill: parent; onClicked: { System.click(); System.toggleBluetooth(); } }
            }

            // Flashlight Button
            Rectangle {
                width: 70; height: 70; radius: 35; color: "#33ffffff"
                Text { anchors.centerIn: parent; text: "\uf0eb"; font.family: fa.name; font.pixelSize: 28; color: "white" }
                MouseArea { anchors.fill: parent; onClicked: { System.click(); System.toggleFlashlight(); } }
            }
        }

        // --- MIDDLE: SLIDERS ---
        Column {
            anchors.top: parent.top; anchors.topMargin: 150
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 30

            // Brightness Slider
            Row {
                spacing: 20
                Text { text: "\uf185"; font.family: fa.name; font.pixelSize: 24; color: "white"; anchors.verticalCenter: parent.verticalCenter }
                Slider { width: 280; from: 1; to: 255; value: 128; onMoved: System.setBrightness(Math.round(value)) }
            }

            // Volume Slider
            Row {
                spacing: 20
                Text { text: "\uf028"; font.family: fa.name; font.pixelSize: 24; color: "white"; anchors.verticalCenter: parent.verticalCenter }
                Slider { width: 280; from: 0; to: 100; value: 50; onMoved: System.setVolume(Math.round(value)) }
            }
        }
    }
}