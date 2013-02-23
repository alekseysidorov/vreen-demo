import QtQuick 2.0

Rectangle {
    id: header

    property Item currentItem: null

    function replace(item) {
        if (currentItem) {
            currentItem.visible = false;
        }
        currentItem = item;
        if (item) {
            item.parent = header;
            item.anchors.fill = header;
            item.anchors.margins = mm;
            item.visible = true;
        }
        header.state = currentItem ? "visible" : "hidden";
    }

    state: "hidden"
    width: parent ? parent.width : 20*mm
    height: Math.max(8*mm, currentItem ? currentItem.implicitHeight : 0)

    states: [
        State {
            name: "visible"
            PropertyChanges {
                target: header
                opacity: 1
            }
        },
        State {
            name: "hidden"
            PropertyChanges {
                target: header
                height: 0
                opacity: 0
            }
        }
    ]

    transitions: [
        Transition {
            from: "hidden"
            to: "visible"
            reversible: true
            NumberAnimation { properties: "opacity, height" }
        }
    ]
}
