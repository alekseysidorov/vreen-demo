import QtQuick 2.0
import com.vk.api 1.0
import "components"
import "delegates"
import "Utils.js" as Utils

SideBarItem {
    id: root

    property alias contact: wallModel.contact

    title: contact.name

    ListView {
        id: wallView

        anchors.fill: parent
        model: wallModel
        delegate: WallPostDelegate {}
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
