import QtQuick 2.0
import Vreen.Base 2.0
import QtQuick.Controls 1.0
import "components"
import "Utils.js" as Utils

SideBarItem {
    id: root

    title: qsTr("Friends")

    function update() {
    }

    ListView {
        id: dialogsView

        anchors.fill: parent
        model: buddyModel
        delegate: ImageItemDelegate {
            width: ListView.view.width

            onClicked: stackView.push(profilePage, { contact: contact })
            imageSource: contact.photoSource

            Label {
                id: titleLabel
                width: parent.width
                font.bold: true
                text: contact.name
                elide: Text.ElideRight
                wrapMode: Text.Wrap
                maximumLineCount: 1
            }

            Label {
                id: descriptionLabel
                width: parent.width
                text: contact.activity
                elide: Text.ElideRight
                wrapMode: Text.Wrap
                maximumLineCount: 3
                color: systemPalette.shadow
            }

            Row {
                width: parent.width

                spacing: 0.5 * mm
            }

        }
        ScrollDecorator {
            flickableItem: parent
        }
    }

    BuddyModel {
        id: buddyModel
        roster: client.roster
    }
}
