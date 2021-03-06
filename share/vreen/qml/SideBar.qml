import QtQuick 2.0
import QtQuick.Controls 1.3

ListView {
    id: sideBar

    property list<SideBarItem> items
    property SideBarItem currentItem

    default property alias __items: sideBar.items

    onCurrentItemChanged: stackView.replace(currentItem)

    model: items

    delegate: Rectangle {
        id: rect

        property bool checked: currentItem == modelData

        width: ListView.view.width
        height: 32
        color: checked ? systemPalette.highlight : "transparent"

        Row {
            width: parent.width
            spacing: 6
            anchors.verticalCenter: parent.verticalCenter

            Image {
                id: icon

                width: 22
                height: width
                source: modelData.iconSource
            }

            Label {
                id: label
                text: modelData.title
                color: checked ? systemPalette.highlightedText : systemPalette.buttonText
            }
        }

        MouseArea {
            id: area

            anchors.fill: parent
            onClicked: { currentItem = modelData; }
            hoverEnabled: true
        }

        Rectangle {
            anchors.fill: parent
            color: systemPalette.highlight
            opacity: area.containsMouse ? 0.1 : 0
        }
    }
}
