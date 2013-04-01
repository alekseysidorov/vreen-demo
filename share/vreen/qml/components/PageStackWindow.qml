import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    id: window

    property alias initialItem: stack.initialItem
    property alias pageStack: stack
    property alias sideBar: sideBar.data
    property SystemPalette systemPalette: systemPalette

    Component.onCompleted: {
        if (initialItem) {
            stack.rebuild();
        }
    }

    SplitView {
        anchors.fill: parent

        //orientation:Qt.Horizontal

        Rectangle {
            id: sideBar
            color: systemPalette.window
            clip: true
            z: contentArea.z + 1
            //Layout.minimumWidth: 30*mm
        }

        Rectangle {
            id: contentArea

            HeaderBar {
                id: header

                z: stack.z+1
                opacity: 0.95

                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
            }

            StackView {
                id: stack

                function rebuild() {
                    var page = pageStack.currentItem;
                    header.replace(page.header);
                    footer.replace(page.footer);
                    updateTimer.start();
                }

                onBusyChanged: {
                    if (!busy)
                        rebuild();
                }

                anchors {
                    top: header.bottom
                    left: parent.left
                    right: parent.right
                    bottom: footer.top
                }

                Timer {
                    id: updateTimer
                    interval: 400
                    onTriggered: pageStack.currentPage.update()
                    repeat: false
                }
            }

            FooterBar {
                id: footer

                z: stack.z+1
                opacity: 0.95

                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                }
            }
        }
    }

    SystemPalette {
        id: systemPalette
    }

    // event preventer when page transition is active
    MouseArea {
        anchors.fill: parent
        enabled: pageStack.busy
    }
}
