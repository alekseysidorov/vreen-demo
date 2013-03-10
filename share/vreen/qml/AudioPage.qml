import QtQuick 2.0
import com.vk.api 1.0
import QtMultimedia 5.0
import "components"
import "delegates"

SideBarItem {
    id: root

    property QtObject owner: client.me

    function update() {
        updater.testAndUpdate();
    }

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

        delegate: AudioDelegate {}
    }

    ScrollDecorator {
        flickableItem: parent
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
