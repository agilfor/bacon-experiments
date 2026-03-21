import QtQuick
import QtQuick.Window
import QtQuick.Layouts // Needed for the Numpad grid

Window {
    id: lockWindow
    width: Screen.width
    height: Screen.height
    visible: true
    title: "iBaconLock"
    
    // State trackers
    property string currentPin: ""
    property bool showPinPad: false
    
    Connections {
        target: System
        function onSleepTriggered() {
            showPinPad = false
            currentPin = ""
        }
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#2c3e50" }
            GradientStop { position: 1.0; color: "#000000" }
        }
    }

    // --- MAIN ANIMATED CONTAINER ---
    Item {
        anchors.fill: parent
        // Slide the whole UI up slightly when the Pin Pad appears
        y: showPinPad ? -50 : 0
        Behavior on y { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }

        // 1. THE CLOCK
        Item {
            anchors.top: parent.top; anchors.topMargin: 100
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width; height: 200
            
            // Fade out when PIN pad shows
            opacity: showPinPad ? 0 : 1
            Behavior on opacity { NumberAnimation { duration: 250 } }

            Text {
                id: timeText
                anchors.horizontalCenter: parent.horizontalCenter
                text: Qt.formatDateTime(new Date(), "hh:mm")
                font.pixelSize: 110; font.bold: true; color: "white"
            }
            Text {
                id: dateText
                anchors.top: timeText.bottom; anchors.horizontalCenter: parent.horizontalCenter
                text: Qt.formatDateTime(new Date(), "dddd, MMMM d")
                font.pixelSize: 24; color: "white"
            }
        }

        // 2. THE NUMPAD
        Item {
            anchors.bottom: parent.bottom; anchors.bottomMargin: 80
            anchors.horizontalCenter: parent.horizontalCenter
            // MADE BIGGER: Increased container width and height
            width: 380; height: 520
            
            // Fade in when PIN pad shows
            opacity: showPinPad ? 1 : 0
            visible: opacity > 0
            Behavior on opacity { NumberAnimation { duration: 300 } }

            Text {
                anchors.top: parent.top; anchors.horizontalCenter: parent.horizontalCenter
                text: "Enter Passcode"; color: "white"; font.pixelSize: 22
            }

            // The 4 PIN Dots
            Row {
                anchors.top: parent.top; anchors.topMargin: 40
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Repeater {
                    model: 4
                    Rectangle {
                        width: 16; height: 16; radius: 8
                        color: currentPin.length > index ? "white" : "transparent"
                        border.color: "white"; border.width: 1
                    }
                }
            }

            // The Buttons
            GridLayout {
                anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter
                columns: 3; rowSpacing: 25; columnSpacing: 35
                Repeater {
                    model: ["1","2","3","4","5","6","7","8","9","","0",""]
                    Rectangle {
                        // MADE BIGGER: Buttons are now 86x86
                        width: 86; height: 86; radius: 43
                        
                        // Hide the background completely if it's the blank spacer button
                        color: modelData === "" ? "transparent" : "#33ffffff"
                        
                        Text {
                            anchors.centerIn: parent; text: modelData
                            color: "white"; font.bold: true
                            font.pixelSize: 30
                        }
                        
                        MouseArea {
                            // Disable clicking entirely on the blank spacer
                            enabled: modelData !== ""
                            anchors.fill: parent
                            
                            onPressed: {
                                System.click() 
                                parent.color = "#66ffffff"
                            }
                            onReleased: {
                                parent.color = "#33ffffff"
                                if (currentPin.length < 4) {
                                    currentPin += modelData
                                    if (currentPin.length === 4) {
                                        if (System.verifyPin(currentPin)) {
                                            // Unlocked!
                                            currentPin = ""
                                            showPinPad = false
                                        } else {
                                            // Wrong PIN, reset dots
                                            currentPin = ""
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // --- NATIVE SWIPE GESTURE ---
    MouseArea {
        anchors.fill: parent
        enabled: !showPinPad
        property int startY: 0
        onPressed: (mouse) => { startY = mouse.y }
        onReleased: (mouse) => {
            if (startY - mouse.y > 100) { // If swiped up more than 100 pixels
                showPinPad = true
            }
        }
    }

    // Clock Timer
    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: {
            timeText.text = Qt.formatDateTime(new Date(), "hh:mm")
            dateText.text = Qt.formatDateTime(new Date(), "dddd, MMMM d")
        }
    }
}