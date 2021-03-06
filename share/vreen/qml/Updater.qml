import QtQuick 2.0
import QtQuick.Controls 1.0

Item {
    id: updater

    property bool canUpdate: client.online && !busy
    property bool busy: false
    property int count: 25
    property int offset: flickableItem.count
    property bool reverse: false

    property ListView flickableItem
    property Component header: Label {
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: qsTr("Loading...")
        color: systemPalette.dark
        visible: updater.state === "updateFirst"
    }
    property Component footer: Label {
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: qsTr("Loading...")
        color: systemPalette.dark
        visible: updater.state === "updateLast"
    }

    function getLast() {
        console.log("getLast");
        var reply = update(count, reverse ? 0 : offset);
        if (reply) {
            state = "updateLast";
            reply.resultReady.connect(function() {
                if (reverse)
                    flickableItem.positionViewAtIndex(flickableItem.count - 1, ListView.End);
                state = "updateFinished";
            });
        }
        return reply;
    }

    function getFirst() {
        console.log("getFirst");
        var reply = update(count, reverse ? offset : 0);
        if (reply) {
            state = "updateFirst";
            flickableItem.currentIndex = 1;
            reply.resultReady.connect(function() {
                state = "updateFinished";
            });
        }
        return reply;
    }

    //protected
    function update(count, offset) {
        console.log("Updater: please implement function with signature update(count, offset)")
    }

    function truncate(count, offset) {
        console.log("Updater: please implement function with signature truncate(count, offset)")
    }

    function testAndUpdate() {
        if (canUpdate) {
            var updateThreshold = 0.1;
            var ratio = flickableItem.visibleArea.yPosition;
            if (ratio > (1 - updateThreshold - flickableItem.visibleArea.heightRatio))
                getLast();
            else if (ratio < updateThreshold)
                getFirst();
        }
    }

    Component.onCompleted: {
        flickableItem.header = header;
        flickableItem.footer = footer;
    }

    onCanUpdateChanged: {
        testAndUpdate();
    }

    Connections {
        target: flickableItem

        onFlickEnded: testAndUpdate()
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

