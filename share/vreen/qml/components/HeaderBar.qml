import QtQuick 2.0

Rectangle {
    id: header

    property Item item: null

    onItemChanged: {
        if (item) {
            item.parent = header;
            item.anchors.fill = header;
            item.anchors.margins = mm;
            item.visible = true;
        }
        header.state = item ? "visible" : "hidden";
    }

    state: "hidden"
    width: parent ? parent.width : 20*mm
    height: Math.max(8*mm, item.implicitHeight)
    border.color: "#d6d652"
    color: "#ffffe1"
    radius: 3
    border.width: 1

    states: [
        State {
            name: "visible"
            PropertyChanges {
                target: header
                //height: Math.max(implicitHeight, stack.currentPage.header.heigth)
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
