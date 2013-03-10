import QtQuick 2.0

Rectangle {
    id: root

    property Item currentItem: null
    property bool busy: false

    function replace(item) {
        if (currentItem) {
            currentItem.visible = false;
        }
        currentItem = item;
        if (item) {
            item.parent = root;
            item.anchors.fill = root;
            item.anchors.margins = mm;
            item.visible = true;
        }
        root.busy = true;
        root.state = currentItem ? "visible" : "hidden";
    }

    state: "hidden"
    width: parent ? parent.width : 20*mm
    height: Math.max(8*mm, currentItem ? currentItem.implicitHeight : 0)

    states: [
        State {
            name: "visible"
            PropertyChanges {
                target: root
                opacity: 1
                busy: false
            }
        },
        State {
            name: "hidden"
            PropertyChanges {
                target: root
                height: 0
                opacity: 0
                busy: false
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
