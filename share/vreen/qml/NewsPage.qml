import QtQuick 2.0
import QtQuick.Controls 1.0

import Vreen.Base 2.0

import "components"
import "delegates"
import "Utils.js" as Utils

SideBarItem {
    id: root

    function update() {
        updater.testAndUpdate();
    }

    Component.onCompleted: {
        newsFeed.client = client;
    }

    title: qsTr("News")

    ListView {
        id: newsView

        model: newsFeed
        anchors.fill: parent
        delegate: WallPostDelegate {}

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
