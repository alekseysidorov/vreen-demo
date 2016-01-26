import QtQuick 2.0
import QtQuick.Layouts 1.0
import Vreen.Base 2.0
import QtQuick.Controls 1.0
import "components"
import "Utils.js" as Utils

SideBarItem {
    id: root

    title: {
        if (dialogsModel.unreadCount > 0)
            return qsTr("Dialogs[%1]".arg(dialogsModel.unreadCount))
        return qsTr("Dialogs")
    }

    function update() {
        updater.testAndUpdate();
    }

    Component.onCompleted: {
        dialogsModel.client = client
    }

    ListView {
        id: dialogsView

        anchors.fill: parent
        model: dialogsModel
        delegate: ImageItemDelegate {
            property QtObject contact: incoming ? from : to;

            onClicked: {
                var properties = {
                    "contact" : contact
                };
                stackView.push(chatPage, properties);
            }

            width: ListView.view.width

            imageSource: contact.photoSource

            Label {
                id: titleLabel
                width: parent.width
                font.bold: true
                text: Utils.contactLabel(from, to, chatId ? qsTr("from chat") : "")
                elide: Text.ElideRight
                wrapMode: Text.Wrap
                maximumLineCount: 1
            }

            Label {
                id: descriptionLabel
                width: parent.width
                text: body
                elide: Text.ElideRight
                wrapMode: Text.Wrap
                maximumLineCount: 3
            }

            Label {
                id: dateLabel

                color: systemPalette.dark
                font.pointSize: 7

                text: Utils.formatDate(date)
            }
        }

        displaced: Transition {
            NumberAnimation { properties: "x,y"; duration: 400 }
        }
        move: Transition {
            NumberAnimation { properties: "x,y"; duration: 400 }
        }

        ScrollDecorator {
            flickableItem: parent
        }
    }

    Updater {
        id: updater

        function update(count, offset) {
            return dialogsModel.getDialogs(count, offset, 160);
        }

        flickableItem: dialogsView
    }

    DialogsModel {
        id: dialogsModel
    }

    ChatPage {
        id: chatPage
    }
}
