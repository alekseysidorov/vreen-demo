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
        if (initialPage)
            pageStack.push(initialPage);
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

            PageStack {
                id: stack
                anchors.fill: parent
                toolBar: toolBar
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
