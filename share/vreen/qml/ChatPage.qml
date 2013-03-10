import QtQuick 2.0
import com.vk.api 1.0
import "components"
import "delegates"
import QtQuick.Controls 1.0
import QtQuick.Window 2.0
import "Utils.js" as Utils

SubPage {
    id: chatPage

    property QtObject contact

    function update() {
        updater.testAndUpdate();
    }

    title: qsTr("Chat with %1").arg(contact ? contact.name : qsTr("Unknown"))
    footer: footer

    onContactChanged: {
        chatModel.setContact(contact);
    }

    ListView {
        id: chatView

        anchors.fill: parent
        model: chatModel
        delegate: ChatDelegate {}

        ScrollDecorator {
            flickableItem: parent
        }
    }

    RowLayout {
        id: footer

        implicitHeight: messageArea.height + 2 * anchors.margins
        anchors.margins: mm

        TextArea {
            id: messageArea

            height: 2 * documentMargins + contentItem.implicitHeight
            verticalScrollBar.visible: false
            Layout.horizontalSizePolicy: Layout.Expanding
        }

        Button {
            id: sendButton

            onClicked: {
                chatModel.sendMessage(messageArea.text);
                messageArea.text = '';
            }

            text: qsTr("Send")

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
