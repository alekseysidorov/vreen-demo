import QtQuick 2.0

Rectangle {
    id: footer

    property Item item: null

    onItemChanged: {
        if (item) {
            item.parent = footer;
            item.anchors.fill = footer;
            item.anchors.margins = mm;
            item.visible = true;
        }
        footer.state = item ? "visible" : "hidden";
    }

    state: "hidden"
    width: parent ? parent.width : 20*mm
    height: Math.max(8*mm, item.implicitHeight)
    color: systemPalette.button

    HorizontalLine {}

    states: [
        State {
            name: "visible"
            PropertyChanges {
                target: footer
                //height: Math.max(implicitHeight, stack.currentPage.header.heigth)
                opacity: 1
            }
        },
        State {
            name: "hidden"
            PropertyChanges {
                target: footer
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
