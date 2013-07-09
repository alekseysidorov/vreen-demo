import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Window 2.1
import QtQuick.Layouts 1.0

ApplicationWindow {
    id: window

    property alias initialItem: stack.initialItem
    property alias stackView: stack
    property Item sideBar
    property SystemPalette systemPalette: systemPalette

    onSideBarChanged: { if (sideBar) sideBar.parent = sideBarArea; }

    Component.onCompleted: {
        if (initialItem) {
            stack.rebuild();
        }
    }

    SplitView {
        anchors.fill: parent
        z: parent.z + 1

        Rectangle {
            id: sideBarArea
            color: systemPalette.window
            clip: true
            z: contentArea.z + 1
            Layout.minimumWidth: 30*mm
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
                    var page = stackView.currentItem;
                    if (page) {
                        header.replace(page.header);
                        footer.replace(page.footer);
                        updateTimer.start();
                    }
                }

                onBusyChanged: {
                    if (!busy) {
                        rebuild();
                    }
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
                    onTriggered: {
                        if (stack.currentItem)
                            stack.currentItem.update();
                    }
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
        enabled: stackView.busy
    }
}
