import QtQuick 2.0
import com.vk.api 1.0
import "components"
import "attachments" as Attach
import "Utils.js" as Utils

SideBarItem {
    id: root

    Component.onCompleted: {
        newsFeed.client = client;
    }

    title: qsTr("News")

    ListView {
        id: newsView

        model: newsFeed
        anchors.fill: parent
        delegate: ImageItemDelegate {
            width: ListView.view.width
            clickable: true

            imageSource: source.photoSource

            Text {
                id: sourceLabel
                text: Utils.contactLabel(source, owner)
                width: parent.width
                font.bold: true
            }

            Text {
                id: bodyLabel
                text: body
                width: parent.width
                wrapMode: Text.WordWrap
                maximumLineCount: 10
            }

            Attach.Photo {
                model: attachments[Attachment.Photo]
            }

            Text {
                id: dateLabel

                color: systemPalette.dark
                font.pointSize: 8

                text: {
                    var info = Qt.formatDateTime(date, qsTr("dddd in hh:mm"));
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

    Updater {
        id: updater
        flickableItem: newsView

        count: 50

        function update(count, offset) {
            return newsFeed.getNews(NewsFeed.FilterNone, count, offset);
        }

        function truncate(count) {
            newsFeed.truncate(count);
        }
    }

    NewsFeedModel {
        id: newsFeed
    }
}
