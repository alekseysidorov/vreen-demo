import QtQuick 2.0
import com.vk.api 1.0
import "private" as Private

Column {
    id: view

    property variant model

    width: parent.width
    spacing: mm

    Private.Loader {
        model: view.model[Attachment.Photo]
        component: Photo {}
    }
}
