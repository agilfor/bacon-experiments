import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    id: root
    width: Screen.width
    height: Screen.height
    visible: true
    color: "#111111"
    title: "Fake iOS"

    property real colWidth: width / 4
    property real appSize: colWidth * 0.75
    property real appRadius: appSize * 0.225

    ListView {
        id: pageView
        anchors.top: parent.top
        anchors.bottom: pageIndicator.top
        anchors.left: parent.left
        anchors.right: parent.right
        clip: true 

        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange
        boundsBehavior: Flickable.DragAndOvershootBounds
        model: 3

        delegate: Item {
            width: pageView.width
            height: pageView.height

            GridView {
                anchors.fill: parent
                anchors.topMargin: 20
                
                // THE FIX: Make the cell a perfect square to match horizontal/vertical padding
                cellWidth: root.colWidth
                cellHeight: root.colWidth 
                
                interactive: false
                model: 20 

                delegate: Item {
                    width: GridView.view.cellWidth
                    height: GridView.view.cellHeight

                    Rectangle {
                        id: appIcon // Give it an ID so we can animate it
                        width: root.appSize
                        height: root.appSize
                        anchors.centerIn: parent 

                        color: Qt.rgba(0.7, 0.9, 1, 0.7)
                        radius: root.appRadius
                        antialiasing: true
                        
                        // iOS Squish Animation
                        scale: touchArea.pressed ? 0.9 : 1.0
                        Behavior on scale { NumberAnimation { duration: 100 } }

                        Text {
                            anchors.centerIn: parent
                            text: "App " + (index + 1)
                            color: "black"
                            font.pixelSize: parent.width * 0.18
                            font.bold: true
                        }

                        // THE TOUCH SENSOR
                        MouseArea {
                            id: touchArea
                            anchors.fill: parent
                            onPressed: System.click()
                            onClicked: {
                                // Send the command to your C++ Launcher!
                                System.launch("foot")
                            }
                        }
                    }
                }
            }
        }
    }

    PageIndicator {
        id: pageIndicator
        count: pageView.count
        currentIndex: pageView.currentIndex
        anchors.bottom: dock.top
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle {
        id: dock
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 15
        anchors.bottomMargin: 25
        
        height: root.appSize + 30 
        color: "#33ffffff"
        radius: 40
        antialiasing: true

        Row {
            anchors.centerIn: parent 
            
            Repeater {
                model: 4
                Item {
                    width: root.colWidth - 7.5 
                    height: dock.height
                    
                    Rectangle {
                        id: appIcon // Give it an ID so we can animate it
                        width: root.appSize
                        height: root.appSize
                        anchors.centerIn: parent 

                        color: Qt.rgba(0.7, 0.9, 1, 0.7)
                        radius: root.appRadius
                        antialiasing: true
                        
                        // iOS Squish Animation
                        scale: touchArea.pressed ? 0.9 : 1.0
                        Behavior on scale { NumberAnimation { duration: 100 } }

                        Text {
                            anchors.centerIn: parent
                            text: "App " + (index + 1)
                            color: "black"
                            font.pixelSize: parent.width * 0.18
                            font.bold: true
                        }

                        // THE TOUCH SENSOR
                        MouseArea {
                            id: touchArea
                            anchors.fill: parent
                            onPressed: System.click()
                            onClicked: {
                                // Send the command to your C++ Launcher!
                                System.launch("foot")
                            }
                        }
                    }
                }
            }
        }
    }
}