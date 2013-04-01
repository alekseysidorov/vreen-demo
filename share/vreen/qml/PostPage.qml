import QtQuick 2.0
import com.vk.api 1.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import "components"
import "delegates"
import "Utils.js" as Utils

SubPage {
    id: root

    property alias contact: commentsModel.contact
    property alias postId: commentsModel.postId

    //wall post fields
    property alias from: root.contact
    property QtObject owner
    property string body
    property string copyText: null
    property variant attachments: null
    property date date

    function update() {
        updater.testAndUpdate();
    }

    title: qsTr("Post from %1 %2").arg(from.name).arg(owner ? qsTr("by %1").arg(owner.name) : "")
    header: header
    footer: footer

    RowLayout {
        id: header

        visible: false
        spacing: mm

        Text {
            text: title

            Layout.fillWidth: true
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                margins: mm
            }
            elide: Text.ElideRight
        }

        Button {
            id: likeBtn

            text: from.type === Contact.BuddyType ? qsTr("Profile") : qsTr("Group")
        }

        Item { width: 2*mm }

        Button {
            id: backButton

            onClicked: pageStack.pop()

            text: qsTr("Back")
        }
    }

    ListView {
        id: wallView

        anchors.fill: parent

        Layout.fillHeight: true
        Layout.fillWidth: true

        model: commentsModel
        delegate: ChatDelegate {}

        ScrollDecorator {
            flickableItem: parent
        }
    }

    Updater {
        id: updater

        function update(count, offset) {
            return commentsModel.getComments(count, offset);
        }

        canUpdate: client.online
        flickableItem: wallView
        header: Column {
            width: parent.width

            WallPostDelegate {
                previewMode: false
                from: root.from
                owner: root.owner
                body: root.body
                copyText: root.copyText
                attachments: root.attachments
                date: root.date
            }

            Rectangle {
                width: parent.width
                height: childrenRect.height
                color: systemPalette.alternateBase

                Column {
                    width: parent.width

                    Text {
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: qsTr("Comments")
                    }

                    HorizontalLine {}
                }
            }
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
            Layout.fillWidth: true
        }

        Button {
            id: sendButton

            onClicked: {
                chatModel.sendMessage(messageArea.text);
                messageArea.text = '';
            }

            text: qsTr("Add comment")

        }
    }

    CommentsModel {
        id: commentsModel
        contact: client.me
    }
}
