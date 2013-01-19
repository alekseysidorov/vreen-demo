import QtQuick 2.0
import com.vk.api 1.0
import "components"
import "Utils.js" as Utils

SideBarItem {
    id: root
    title: qsTr("Dialogs")

    Component.onCompleted: {
        dialogsModel.client = client
    }

    ListView {
        id: dialogsView

        anchors.fill: parent
        model: dialogsModel
        delegate: ImageItemDelegate {
            property QtObject contact: incoming ? from : to;

            width: ListView.view.width

            imageSource: contact.photoSource

            Text {
                id: titleLabel
                width: parent.width
                font.bold: true
                text: Utils.contactLabel(from, to, chatId ? qsTr("(from chat)") : "")
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

                text: {
                    var info = Qt.formatDateTime(date, qsTr("dddd in hh:mm"));
                    if (unread)
                        info += qsTr(", unread");
                    if (Object.keys(attachments).length > 0)
                        info += qsTr(", has attachments")
                    return info;
                }
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

    DialogsModel {
        id: dialogsModel
    }

    Connections {
        target: client

        onOnlineChanged: {
            if (client.online) {
                client.roster.sync();
                dialogsModel.getDialogs(0, 50, 160);
            }
        }
    }
}
