import QtQuick 2.0
import QtQuick.Controls 1.0
import "../components"

SimpleImageItemDelegate {
    id: item

    onClicked: audioView.playingIndex = index;
    showArrow: false

    imageSource: "../images/media-optical-audio.png"
    leftSideWidth: 48

    Label {
        id: titleLabel
        width: parent.width
        font.bold: true
        text: artist
        elide: Text.ElideRight
        wrapMode: Text.Wrap
        maximumLineCount: 1
    }

    Label {
        id: descriptionLabel
        width: parent.width
        text: title
        elide: Text.ElideRight
        wrapMode: Text.Wrap
        maximumLineCount: 1
    }

    Rectangle {
        id: background
        color: "black"

        opacity: index === audioView.playingIndex ? 0.15 : 0

        height: 1.5 * mm
        radius: 1 * mm
        width: parent.width

        Rectangle {
            id: progress

            property real percentState: player.position / (duration * 1000)

            color: "black"
            height: parent.height

            width: parent.width * percentState
        }
    }

    Label {
        id: durationLabel

        color: systemPalette.dark
        width: parent.width
        wrapMode: Text.Wrap
        maximumLineCount: 1
        font.pointSize: 8

        text: qsTr("Duration %2").arg((duration / 60).toFixed(2))
    }
}
