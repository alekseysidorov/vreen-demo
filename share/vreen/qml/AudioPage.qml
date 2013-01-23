import QtQuick 2.0
import com.vk.api 1.0
import QtMultimedia 5.0
import "components"

SideBarItem {
    id: root

    property QtObject owner: client.me

    onOwnerChanged: {
        audioModel.clear();
    }

    Component.onCompleted: {
        audioModel.client = client;
    }

    title: qsTr("Audio")

    Audio {
        id: player

        onStatusChanged: {
            switch (status) {
            case Audio.Stalled:
                break
            case Audio.Buffered:
                break
            case Audio.EndOfMedia:
                if (audioView.playingIndex === audioModel.count - 1)
                    audioView.playingIndex = 0
                else
                    audioView.playingIndex++;
            }
        }

        volume: 0.2
    }

    AudioModel {
        id: audioModel
    }

    ListView {
        id: audioView

        property int playingIndex: -1

        function play(index) {
            player.stop();
            player.source = audioModel.get(index, "url");
            player.play();
        }

        onPlayingIndexChanged: {
            if (playingIndex === -1)
                player.pause();
            else
                play(playingIndex);
        }

        anchors.fill: parent
        model: audioModel

        header: Text {
            width: parent.width
            height: 50
            text: qsTr("%1 latest audio").arg(owner ? owner.name : qsTr("Unknown"))
            font.bold: true
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
        }

        add: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 400 }
            NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 400 }
        }

        delegate: SimpleImageItemDelegate {
            id: item

            onClicked: audioView.playingIndex = index;

            imageSource: "images/media-optical-audio.png"
            leftSideWidth: 48

            Text {
                id: titleLabel
                width: parent.width
                font.bold: true
                text: artist
                elide: Text.ElideRight
                wrapMode: Text.Wrap
                maximumLineCount: 1
            }

            Text {
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

            Text {
                id: durationLabel

                color: systemPalette.dark
                width: parent.width
                wrapMode: Text.Wrap
                maximumLineCount: 1
                font.pointSize: 8

                text: qsTr("Duration %2").arg((duration / 60).toFixed(2))
            }
        }

        ScrollDecorator {
            flickableItem: parent
        }
    }

    Updater {
        id: updater

        count: 25

        function update(count, offset) {
            //TODO add support for audio searching
            return audioModel.getAudio(owner.id, count, offset);
        }

        flickableItem: audioView
    }
}
