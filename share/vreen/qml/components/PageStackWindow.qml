import QtQuick 2.0
import QtDesktop 1.0
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

    SplitterRow {
        anchors.fill: parent
        handleWidth: 1

        Rectangle {
            id: sideBar
            Splitter.minimumWidth: 180
            color: systemPalette.window
            clip: true
            z: contentArea.z + 1
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
                    header.item = pageStack.currentPage ? pageStack.currentPage.header : null;
                    footer.item = pageStack.currentPage ? pageStack.currentPage.footer : null;
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
