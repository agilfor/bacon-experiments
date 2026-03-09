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
                anchors.topMargin: 50 
                
                // THE FIX: Make the cell a perfect square to match horizontal/vertical padding
                cellWidth: root.colWidth
                cellHeight: root.colWidth 
                
                interactive: false
                model: 20 

                delegate: Item {
                    width: GridView.view.cellWidth
                    height: GridView.view.cellHeight

                    Rectangle {
                        width: root.appSize
                        height: root.appSize
                        // THE FIX: Center the app inside the square cell for uniform margins!
                        anchors.centerIn: parent 
                        
                        color: Qt.hsla(Math.random(), 0.7, 0.5, 1)
                        radius: root.appRadius
                        antialiasing: true

                        Text {
                            anchors.centerIn: parent
                            text: "App " + (index + 1)
                            color: "white"
                            font.pixelSize: parent.width * 0.18
                            font.bold: true
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
                        width: root.appSize
                        height: root.appSize
                        anchors.centerIn: parent 
                        
                        color: Qt.hsla(Math.random(), 0.7, 0.5, 1)
                        radius: root.appRadius
                        antialiasing: true
                    }
                }
            }
        }
    }
}