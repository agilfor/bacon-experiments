import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    id: ccWindow
    width: 380; height: 350
    visible: true
    title: "ControlCenter"
    color: "transparent" // The Sway window itself is invisible
    flags: Qt.FramelessWindowHint

    FontLoader {
        id: fa
        source: "file://" + System.executeCommand("echo $HOME") + "/bacon-experiments/iBacon/fontawesome.ttf" 
        // Note: Hardcoding the path is safer in QML if the above dynamic path fails:
        // source: "file:///home/YOUR_USERNAME/bacon-experiments/iBacon/fontawesome.ttf"
    }

    // The Translucent Glass Panel
    Rectangle {
        anchors.fill: parent
        anchors.margins: 10
        radius: 25
        color: "#d91e1e1e" // Dark translucent grey
        border.color: "#33ffffff"
        border.width: 1

        // --- TOP ROW: TOGGLE BUTTONS ---
        Row {
            anchors.top: parent.top; anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 25

            // Wi-Fi Button
            Rectangle {
                width: 66; height: 66; radius: 33; color: "#33ffffff"
                Text { anchors.centerIn: parent; text: "\uf1eb"; font.family: fa.name; font.pixelSize: 24; color: "white" }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        System.click();
                        System.executeCommand("nmcli radio wifi toggle");
                        parent.color = parent.color == "#33ffffff" ? "#0a84ff" : "#33ffffff" // Fake toggle state
                    }
                }
            }

            // Bluetooth Button
            Rectangle {
                width: 66; height: 66; radius: 33; color: "#33ffffff"
                Text { anchors.centerIn: parent; text: "\uf293"; font.family: fa.name; font.pixelSize: 28; color: "white" }
                MouseArea {
                    anchors.fill: parent
                    onClicked: { System.click(); System.executeCommand("rfkill toggle bluetooth"); }
                }
            }

            // Flashlight Button
            Rectangle {
                width: 66; height: 66; radius: 33; color: "#33ffffff"
                Text { anchors.centerIn: parent; text: "\uf0eb"; font.family: fa.name; font.pixelSize: 26; color: "white" }
                MouseArea {
                    anchors.fill: parent
                    onClicked: { 
                        System.click(); 
                        // Note: You will need to find the exact sysfs path for the OnePlus One flashlight
                        System.executeCommand("brightnessctl --device='led:flash_torch' set 1 || brightnessctl --device='flashlight' set 1"); 
                    }
                }
            }
        }

        // --- MIDDLE: BRIGHTNESS SLIDER ---
        Column {
            anchors.centerIn: parent
            spacing: 20

            Row {
                spacing: 15
                Text { text: "\uf185"; font.family: fa.name; font.pixelSize: 20; color: "white"; anchors.verticalCenter: parent.verticalCenter }
                Slider {
                    width: 260
                    from: 1; to: 255; value: 128
                    onMoved: System.executeCommand("brightnessctl set " + Math.round(value))
                }
            }

            // --- BOTTOM: VOLUME SLIDER ---
            Row {
                spacing: 15
                Text { text: "\uf028"; font.family: fa.name; font.pixelSize: 20; color: "white"; anchors.verticalCenter: parent.verticalCenter }
                Slider {
                    width: 260
                    from: 0; to: 100; value: 50
                    onMoved: System.executeCommand("amixer set Master " + Math.round(value) + "%")
                }
            }
        }
    }
}