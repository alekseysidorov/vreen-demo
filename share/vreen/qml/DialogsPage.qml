import QtQuick 2.0
import com.vk.api 1.0
import "components"

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

        header: Text {
            width: parent.width
            height: 50
            text: qsTr("Last dialogs")
            font.bold: true
            font.pixelSize: 12
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
        }

        add: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
            NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
        }

        delegate: Rectangle {
            id: item

            property QtObject contact: incoming ? from : to;

            Component.onCompleted: {
                from.update();
                to.update();
            }

            width: parent.width
            height: 120
            color: index % 2 ? systemPalette.alternateBase : "transparent"

            Image {
                id: preview

                width: 75
                height: Math.min(sourceSize.height, 75)

                source: contact.photoSource
                fillMode: Image.PreserveAspectFit
                clip: true
                smooth: true

                anchors {
                    left: parent.left
                    leftMargin: 5
                    top: column.top
                }
            }

            Column {
                id: column

                spacing: 2

                anchors {
                    left: preview.right
                    top: parent.top
                    right: parent.right
                    bottom: parent.bottom
                    leftMargin: 10
                    rightMargin: 10
                    topMargin: 10
                }

                Text {
                    id: titleLabel
                    width: parent.width
                    font.bold: true
                    text: qsTr("%1 ➜ %2 %3").arg(from.name).arg(to.name).arg(chatId ? qsTr("(from chat)") : "")
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
            }

            Text {
                id: dateLabel

                color: systemPalette.dark
                font.pixelSize: 9

                anchors {
                    bottom: hr.top
                    bottomMargin: 3
                    left: column.left
                }
                text: {
                    var info = Qt.formatDateTime(date, qsTr("dddd in hh:mm"));
                    if (unread)
                        info += qsTr(", unread");
                    if (Object.keys(attachments).length > 0)
                        info += qsTr(", has attachments")
                    return info;
                }
            }

            Rectangle {
                id: hr
                width: parent.width
                height: 1
                anchors.bottom: parent.bottom
                color: systemPalette.window
            }
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
