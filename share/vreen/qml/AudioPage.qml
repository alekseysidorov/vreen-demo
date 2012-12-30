import QtQuick 2.0
import com.vk.api 1.0
import QtMultimedia 5.0

SideBarItem {
    id: root

    property QtObject owner: client.me

    onOwnerChanged: {
        audioModel.getAudio(owner.id, 50, 0);
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

        volume: 0.5
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

        delegate: Rectangle {
            id: item

            width: parent.width
            height: 80
            color: index % 2 ? systemPalette.alternateBase : "transparent"

            Image {
                id: preview

                source: "images/media-optical-audio.png"

                fillMode: Image.PreserveAspectFit
                clip: true
                smooth: true

                anchors {
                    left: parent.left
                    leftMargin: 5
                    top: column.top
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: audioView.playingIndex = index;
                }
            }

            Column {
                id: column

                spacing: 2

                anchors {
                    left: preview.right
                    top: parent.top
                    right: parent.right
                    bottom: parent.bottom
                    leftMargin: 10
                    rightMargin: 10
                    topMargin: 10
                }

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

                Text {
                    id: durationLabel

                    color: systemPalette.dark
                    width: parent.width
                    wrapMode: Text.Wrap
                    maximumLineCount: 1

                    text: qsTr("Duration %2").arg((duration / 60).toFixed(2))
                }
            }

            Rectangle {
                id: background
                color: "black"

                opacity: index === audioView.playingIndex ? 0.15 : 0

                height: 6
                radius: 6

                anchors {
                    bottom: hr.top
                    bottomMargin: 6
                    left: column.left
                    right: column.right
                }

                Rectangle {
                    id: progress

                    property real percentState: player.position / (duration * 1000)

                    color: "black"
                    height: parent.height

                    width: parent.width * percentState
                }
            }

            Rectangle {
                id: hr
                width: parent.width
                height: 1
                anchors.bottom: parent.bottom
                color: systemPalette.window
            }
        }

        ScrollDecorator {
            flickableItem: parent
        }
    }
}
