import QtQuick 2.0
import "Units.js" as Units

Rectangle {
    id: root

    property bool clickable: false
    property alias imageData: imageContainer.data
    property int imageWidth: 80
    property alias data: container.data

    signal clicked;

    width: parent ? parent.width : implicitWidth
    color: index % 2 ? systemPalette.alternateBase : "transparent"

    implicitWidth: 200
    implicitHeight: Math.max(Units.gu(12), container.last.height + container.last.y + Units.gu(2))

    Item {
        id: imageContainer

        width: imageWidth

        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            leftMargin: Units.gu(1)
        }
    }

    Column {
        id: container

        property Item last;

        onChildrenChanged: {
            last = children[children.length - 1];
        }

        spacing: Units.gu(1)

        anchors {
            top: parent.top
            topMargin: Units.gu(1)
            bottom: parent.bottom
            bottomMargin: Units.gu(1)
            left: imageContainer.right
            leftMargin: Units.gu(1)
            right: arrow.left
            rightMargin: Units.gu(1)
        }
    }

    Text {
        id: arrow

        width: clickable ? implicitWidth : 0
        visible: clickable ? 0 : 1
        text: qsTr("❭")
        color: systemPalette.shadow

        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            rightMargin: Units.gu(2)
        }

        verticalAlignment: Text.AlignVCenter
    }

    Rectangle {
        id: hr
        width: parent.width
        height: 1
        anchors.bottom: parent.bottom
        color: systemPalette.window
    }
}
