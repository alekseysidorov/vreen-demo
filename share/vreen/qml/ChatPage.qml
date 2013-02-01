import QtQuick 2.0
import com.vk.api 1.0
import "components"
import QtDesktop 1.0
import QtQuick.Window 2.0
import "Utils.js" as Utils

Page {
    id: chatPage

    property QtObject contact
    property string title: qsTr("Chat with %1").arg(contact.name)

    onContactChanged: {
        chatModel.setContact(contact);
    }

    ListView {
        id: chatView

        anchors.fill: parent
        model: chatModel
        delegate: ImageItemDelegate {

            Component.onCompleted: from.update()

            width: ListView.view.width
            imageSource: from.photoSource
            clickable: true

            Text {
                id: titleLabel
                width: parent.width
                font.bold: true
                text: from.name
                elide: Text.ElideRight
                wrapMode: Text.Wrap
                maximumLineCount: 1
            }

            Text {
                id: descriptionLabel
                width: parent.width
                text: body
                elide: Text.ElideRight
                wrapMode: Text.Wrap
                maximumLineCount: 3
            }

            Text {
                id: dateLabel

                color: systemPalette.dark
                font.pointSize: 7

                text: Utils.formatDate(date)
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

    Updater {
        id: updater

        function update(count, offset) {
            return chatModel.getHistory(count, offset);
        }

        flickableItem: chatView
        reverse: true
    }

    ChatModel {
        id: chatModel
    }
}
