import QtQuick 2.0
import com.vk.api 1.0
import QtDesktop 1.0
import "components"
import "delegates"
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
        delegate: WallPostDelegate {
            onClicked: {
                pageStack.push(contactPage, { contact: from })
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

    ProfilePage {
        id: contactPage

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
