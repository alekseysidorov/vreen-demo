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
        visible: updater.state === "updateFirst"
    }
    property Component footer: Text {
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: qsTr("Loading...")
        color: systemPalette.dark
        visible: updater.state === "updateLast"
    }

    function getLast() {
        var reply = update(count, reverse ? 0 : offset);
        state = "updateLast";
        processReply(reply);
        return reply;
    }

    function getFirst() {
        truncate(2 * count);
        var reply = update(count, reverse ? offset : 0);
        state = "updateFirst";
        processReply(reply);
        return reply;
    }

    //protected
    function update(count, offset) {
        console.log("Updater: please implement function with signature update(count, offset)")
    }

    function truncate(count) {
        console.log("Updater: please implement function with signature truncate(count)")
    }

    //internal
    function processReply(reply) {
        reply.resultReady.connect(function() {
            state = "updateFinished";
        });
    }

    onFlickableItemChanged: {
        flickableItem.header = header;
        flickableItem.footer = footer;
    }

    Connections {
        target: flickableItem

        onFlickEnded: {
            if (canUpdate) {
                var updateMargin = 10 * mm;
                if (flickableItem.contentY < updateMargin)
                    getFirst();
                else if (flickableItem.contentY + flickableItem.height > (flickableItem.contentHeight - updateMargin))
                    getLast();
            }
        }
    }

    states: [
        State {
            name: "updateFirst"
        },
        State  {
            name: 'updateLase'
        },
        State {
            name: "updateFinished"
        }

    ]
}

