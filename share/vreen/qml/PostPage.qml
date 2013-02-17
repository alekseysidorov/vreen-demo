import QtQuick 2.0
import com.vk.api 1.0
import QtDesktop 1.0
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
    property variant attachments
    property date date

    title: qsTr("Post from %1 %2").arg(from.name).arg(owner ? qsTr("by %1").arg(owner.name) : "")

    ListView {
        id: wallView

        anchors.fill: parent

        Layout.verticalSizePolicy: Layout.Expanding
        Layout.horizontalSizePolicy: Layout.Expanding

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

            WallPostDelegate { previewMode: false }

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

    CommentsModel {
        id: commentsModel
        contact: client.me
    }
}
