import QtQuick 2.0

Item {
    id: updater

    property bool canUpdate: client.online && !busy
    property bool busy: false
    property int count: 25
    property int offset: flickableItem.count
    property bool reverse: false

    property ListView flickableItem
    property Component header: Text {
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: qsTr("Loading...")
        color: systemPalette.dark
        visible: updater.busy
    }
    property Component footer: Text {
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: qsTr("Loading...")
        color: systemPalette.dark
        visible: updater.busy
    }

    function update(count, offset) {
        console.log("Updater: please implement function with signature update(count, offset)")
    }

    function truncate(count) {
        console.log("Updater: please implement function with signature truncate(count)")
    }

    function getLast() {
        return update(count, reverse ? 0 : offset);
    }

    function getFirst() {
        truncate(2 * count);
        return update(count, reverse ? offset : 0);
    }

    onFlickableItemChanged: {
        flickableItem.header = header;
        flickableItem.footer = footer;
    }

    Connections {
        target: flickableItem

        onAtYEndChanged: {
            if (flickableItem.atYEnd && canUpdate) {
                var reply = getLast();
                if (reply) {
                    busy = true;
                    reply.resultReady.connect(function() {
                        busy = false;
                    });
                }
            }
        }

        onAtYBeginningChanged: {
            if (flickableItem.atYBeginning && canUpdate) {
                var reply = getFirst();
                if (reply) {
                    busy = true;
                    reply.resultReady.connect(function() {
                        busy = false;
                    });
                }
            }
        }
    }
}

