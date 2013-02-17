import QtQuick 2.0
import com.vk.api 1.0
import "../components"
import "../attachments" as Attach
import "../Utils.js" as Utils

ImageItemDelegate {
    property bool previewMode: true

    width: parent ? parent.width : 600
    clickable: previewMode
    alternate: previewMode

    Component.onCompleted: {
        from.update();
        if (owner)
            owner.update();
    }

    onClicked: {
        var properties = {
            contact: from,
            postId: postId,
            owner: owner ? owner : null,
            body: body,
            attachments: attachments,
            date: date
        };
        pageStack.push(postPage, properties);
    }
    onImageClicked: {
        pageStack.push(profilePage, { contact: from });
    }

    imageSource: from.photoSource

    Text {
        id: titleLabel

        visible: previewMode
        width: parent.width
        font.bold: true
        text: Utils.contactLabel(from, owner)
        elide: Text.ElideRight
        wrapMode: Text.Wrap
        maximumLineCount: 2
    }

    Text {
        id: descriptionLabel
        width: parent.width
        text: body
        elide: Text.ElideRight
        wrapMode: Text.Wrap
        maximumLineCount: previewMode ? 6 : 0
    }

    Attach.Photo {
        model: attachments[Attachment.Photo]
    }

    Text {
        id: dateLabel

        color: systemPalette.dark
        font.pointSize: 7

        text: Utils.formatDate(date)
    }
}
