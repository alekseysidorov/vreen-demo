import QtQuick 2.0
import com.vk.api 1.0
import QtDesktop 1.0
import "components"

Item {
    id: main

    SplitterRow {
        id: splitterRow
        handleWidth: 1
        anchors.fill: parent

        Rectangle {
            id: sideBar

            color: syspal.window
            Splitter.minimumWidth: 180
            Splitter.expanding: false
        }

        PageStack {
            id: stack
            initialPage: dialogsPage
        }
    }

    DialogsPage {
        id: dialogsPage
    }
}
