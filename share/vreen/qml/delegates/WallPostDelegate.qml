import QtQuick 2.0
import Vreen.Base 2.0
import QtQuick.Controls 1.0
import "../components"
import "../attachments" as Attach
import "../Utils.js" as Utils

ImageItemDelegate {
    property bool previewMode: true

    //wall post fields
    property QtObject from: model.from
    property QtObject owner: Utils.checkProperty(model.owner)
    property string body: model.body
    property string copyText: Utils.checkProperty(model.copyText, '')
    property variant attachments: model.attachments
    property date date: model.date

    width: parent ? parent.width : 600
    clickable: previewMode
    alternate: previewMode

    Component.onCompleted: {
        if (from)
            from.update();
        if (owner)
            owner.update();
    }

    onClicked: {
        var properties = {
            contact: from,
            postId: postId,
            owner: (typeof(owner) != "undefined" ? owner : null),
            body: body,
            copyText: (typeof(copyText) != "undefined" ? copyText : ""),
            attachments: attachments,
            date: date
        };
        stackView.push(postPage, properties);
    }
    onImageClicked: {
        stackView.push(profilePage, { contact: from });
    }

    imageSource: from.photoSource

    Component {
        id: textComponent
        Text {
            id: copyLabel
            width: parent.width
            elide: Text.ElideRight
            wrapMode: Text.Wrap
        }
    }

    Loader {
        width: parent.width

        onLoaded: {
            item.text = Qt.binding(function() { return from.name; })
            item.maximumLineCount = 2;
            item.font.bold = true
        }

        sourceComponent:  textComponent
        active: previewMode
    }

    Loader {
        width: parent.width

        onLoaded: {
            item.text = Qt.binding(function() { return copyText })
            item.maximumLineCount = previewMode ? 3 : 0;
        }

        sourceComponent: textComponent
        active: copyText
    }

    Loader {
        width: parent.width

        onLoaded: {
            item.text = Qt.binding(function() { return qsTr("← %1").arg(owner.name) })
            item.maximumLineCount = 2;
            item.font.bold = true
        }

        sourceComponent: textComponent
        active: owner
    }

    Text {
        id: descriptionLabel
        width: parent.width
        text: body
        elide: Text.ElideRight
        wrapMode: Text.Wrap
        maximumLineCount: previewMode ? 6 : 0
    }

    Attach.View {
        model: attachments
    }

    Text {
        id: dateLabel

        color: systemPalette.dark
        font.pointSize: 7

        text: Utils.formatDate(date)
    }

    Loader {
        sourceComponent: previewMode ? likeIndicator : liker
        visible: false;

        onLoaded: {
            item.parent = parent;
        }
    }

    Component {
        id: likeIndicator
        Row {
            width: parent.width
            spacing: mm

            Text {
                text: qsTr("Reposts: %1, likes: %2, comments: %3").arg(reposts.count).arg(likes.count).arg(comments.count)
            }
        }
    }

    Component {
        id: liker
        Row {
            width: parent.width
            spacing: mm

            Button {
                id: repostButton

                text: qsTr("Repost")
            }

            Button {
                id: likeButton

                text: qsTr("Like")
            }
        }
    }
}
