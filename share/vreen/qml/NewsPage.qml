import QtQuick 2.0
import com.vk.api 1.0
import "components"
import "Utils.js" as Utils

SideBarItem {
    id: root

    function update() {
        updater.updateCurrent();
    }

    Component.onCompleted: {
        newsFeed.client = client;
    }

    title: qsTr("News")

    QtObject {
        id : updater

        function getNext() {
            var reply = newsFeed.getNews(NewsFeed.FilterNone, updater.count, updater.offset);
            reply.resultReady.connect(function(response) {
                if (!reply.error()) {
                    updater.offset = response.new_offset;
                }
            })
        }
        function updateCurrent() {
            var reply = newsFeed.getNews(NewsFeed.FilterNone, updater.offset, updater.count);
        }
        function truncate(count) {

        }

        property int offset: 0
        property int count: 25
    }

    ListView {
        id: newsView

        onAtYEndChanged: {
            if (atYEnd && client.online) {
                updater.getNext();
            }
        }

        model: newsFeed
        anchors.fill: parent
        delegate: ImageItemDelegate {
            width: ListView.view.width

            imageSource: source.photoSource

            Text {
                id: sourceLabel
                text: Utils.contactLabel(source)
                width: parent.width
                font.bold: true
            }

            Text {
                id: bodyLabel
                text: body
                width: parent.width
                wrapMode: Text.WordWrap
            }

            Text {
                id: dateLabel

                color: systemPalette.dark
                font.pointSize: 7

                text: {
                    var info = Qt.formatDateTime(date, qsTr("dddd in hh:mm"));
                    if (Object.keys(attachments).length > 0)
                        info += qsTr(", has attachments")
                    return info;
                }
            }
        }

        footer: Text {
            width: ListView.view.width
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: qsTr("Loading...")
        }

        add: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
            NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
        }

        ScrollDecorator {
            flickableItem: parent
        }
    }

    NewsFeedModel {
        id: newsFeed
    }
}
