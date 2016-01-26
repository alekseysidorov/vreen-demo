import QtQuick 2.0
import Vreen.Base 2.0
import QtQuick.Controls 1.0
import "../components"
import "../attachments" as Attach
import "../Utils.js" as Utils

ImageItemDelegate {

    Component.onCompleted: from.update()

    width: ListView.view.width
    imageSource: from.photoSource
    clickable: true

    Label {
        id: titleLabel
        width: parent.width
        font.bold: true
        text: from.name
        elide: Text.ElideRight
        wrapMode: Text.Wrap
        maximumLineCount: 1
    }

    Label {
        id: descriptionLabel
        width: parent.width
        text: body
        elide: Text.ElideRight
        wrapMode: Text.Wrap
        maximumLineCount: 3
    }

    Attach.View {
        model: attachments
    }

    Label {
        id: dateLabel

        color: systemPalette.dark
        font.pointSize: 7

        text: Utils.formatDate(date)
    }
}
