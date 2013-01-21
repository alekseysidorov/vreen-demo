import QtQuick 2.0

ItemDelegate {
    property alias imageSource: image.source
    property alias imageWidth: image.width
    property alias imageHeight: image.height

    leftSideData: Image {
        id: image

        width: leftSideWidth
        height: width

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 2 * mm
    }
}
