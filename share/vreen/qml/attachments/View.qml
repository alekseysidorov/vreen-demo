import QtQuick 2.0
import com.vk.api 1.0
import "private" as Private

Column {
    id: view

    width: parent.width
    spacing: mm

    Private.Loader {
        model: attachments ? attachments[Attachment.Photo] : null
        component: Photo {}
    }
}
