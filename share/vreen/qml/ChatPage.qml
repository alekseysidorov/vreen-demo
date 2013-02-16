import QtQuick 2.0
import com.vk.api 1.0
import "components"
import QtDesktop 1.0
import QtQuick.Window 2.0
import "Utils.js" as Utils

Page {
    id: chatPage

    property QtObject contact
    property string title: qsTr("Chat with %1").arg(contact ? contact.name : qsTr("Unknown"))

    onContactChanged: {
        chatModel.setContact(contact);
    }

    HeaderBar {
        id: header
        anchors.top: parent.top
        opacity: 0.95

        Text {
            anchors {
                verticalCenter: parent.verticalCenter
                margins: 2 * mm
                left: parent.left
            }
            text: title
        }

        Button {
            id: backButton

            onClicked: pageStack.pop()

            text: qsTr("Back")

            anchors {
                right: parent.right
                top: parent.top
                bottom: parent.bottom
                margins: mm
            }
        }
    }

    ListView {
        id: chatView

        z: header.z - 1
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

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
            return chatModel.getHistory(count, offset);
        }

        flickableItem: chatView
        reverse: true
    }

    ChatModel {
        id: chatModel
    }
}
