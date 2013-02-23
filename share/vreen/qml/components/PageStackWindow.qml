import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Window 2.0

ApplicationWindow {
    id: window

    property variant initialPage
    property alias pageStack: stack
    property alias sideBar: sideBar.data
    property SystemPalette systemPalette: systemPalette

    Component.onCompleted: {
        if (initialPage) {
            pageStack.push(initialPage);
            stack.rebuild();
        }
    }

    SplitView {
        anchors.fill: parent

        orientation:Qt.Horizontal

        Rectangle {
            id: sideBar
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

            PageStack {
                id: stack

                function rebuild() {
                    var page = pageStack.currentPage;
                    header.replace(page.header);
                    footer.replace(page.footer);
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
