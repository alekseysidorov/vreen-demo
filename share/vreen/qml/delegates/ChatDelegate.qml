import QtQuick 2.0
import "../components"
import "../Utils.js" as Utils

ImageItemDelegate {

    Component.onCompleted: from.update()

    width: ListView.view.width
    imageSource: from.photoSource
    clickable: true

    Text {
        id: titleLabel
        width: parent.width
        font.bold: true
        text: from.name
        elide: Text.ElideRight
        wrapMode: Text.Wrap
        maximumLineCount: 1
    }

    Text {
        id: descriptionLabel
        width: parent.width
        text: body
        elide: Text.ElideRight
        wrapMode: Text.Wrap
        maximumLineCount: 3
    }

    Text {
        id: dateLabel

        color: systemPalette.dark
        font.pointSize: 7

        text: Utils.formatDate(date)
    }
}
