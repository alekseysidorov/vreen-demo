import QtQuick 2.0
import com.vk.api 1.0
import "components"
import "delegates"
import "Utils.js" as Utils

SideBarItem {
    id: root

    function update() {
        updater.testAndUpdate();
    }

    property alias contact: wallModel.contact

    title: qsTr("Viewing %1's profile").arg(contact.name)

    ListView {
        id: wallView

        anchors.fill: parent
        model: wallModel
        delegate: WallPostDelegate {}

        ScrollDecorator {
            flickableItem: parent
        }
    }

    Updater {
        id: updater

        function update(count, offset) {
            return wallModel.getPosts(count, offset);
        }

        canUpdate: client.online
        flickableItem: wallView

    }

    WallModel {
        id: wallModel
        contact: client.me
    }
}
