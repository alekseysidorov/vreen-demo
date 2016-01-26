import QtQuick 2.0

Rectangle {
    id: root

    property alias currentItem: contentLoader.item
    property bool busy: false

    function replace(component) {
        contentLoader.sourceComponent = component;
        root.busy = true;
        root.state = currentItem ? "visible" : "hidden";
    }

    state: "hidden"
    width: parent ? parent.width : 20*mm
    height: Math.max(8*mm, currentItem ? currentItem.implicitHeight : 0) + 4 * mm

    Loader {
        id: contentLoader

        anchors.fill: parent
        anchors.margins: mm
        asynchronous: true
    }

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
