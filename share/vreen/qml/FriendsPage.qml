import QtQuick 2.0
import com.vk.api 1.0
import "components"
import "Utils.js" as Utils

SideBarItem {
    id: root

    title: qsTr("Friends")

    ListView {
        id: dialogsView

        anchors.fill: parent
        model: buddyModel
        delegate: ImageItemDelegate {
            width: ListView.view.width

            imageSource: contact.photoSource

            Text {
                id: titleLabel
                width: parent.width
                font.bold: true
                text: contact.name
                elide: Text.ElideRight
                wrapMode: Text.Wrap
                maximumLineCount: 1
            }

            Text {
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

        add: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
            NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
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
