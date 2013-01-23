import QtQuick 2.0

Grid {
    id: grid
    property alias model: repeater.model
    property int imageWidth: 15 * mm

    clip: true
    spacing: mm
    columns: mm

    Repeater {
        id: repeater

        delegate: Image {
            id: image

            opacity: status === Image.Ready ? 1 : 0.1 //hack for constant size
            source: modelData.src_small ? modelData.src_small : modelData.src
            fillMode: Image.PreserveAspectCrop
            clip: true
            width: imageWidth
            height: width

            Behavior on opacity {
                NumberAnimation {
                    easing.type: Easing.InOutQuad
                }
            }

            MouseArea {
                anchors.fill: parent
            }
        }
    }

}
