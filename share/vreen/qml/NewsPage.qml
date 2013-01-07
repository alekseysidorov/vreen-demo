import QtQuick 2.0
import com.vk.api 1.0
import "components"

SideBarItem {
    id: root

    function update() {
        newsFeed.getNews();
        console.log("NewsPage.update()")
    }

    Component.onCompleted: {
        newsFeed.client = client;
    }

    title: qsTr("News")

    ListView {
        id: newsView

        model: newsFeed
        anchors.fill: parent
        delegate: ImageItemDelegate {
            width: newsView.width

            imageSource: source.photoSource

            Text {
                id: sourceLabel
                text: source.name
                width: parent.width
            }

            Text {
                id: bodyLabel
                text: body
                width: parent.width
                wrapMode: Text.WordWrap
            }
        }

        ScrollDecorator {
            flickableItem: parent
       }
    }

    NewsFeedModel {
        id: newsFeed
    }
}
