import QtQuick 2.0
import com.vk.api 1.0
import "private" as Private

Column {
    id: view

    property variant model: null
    property variant allowedTypes: [Attachment.Photo, Attachment.Link, Attachment.Audio]

    width: parent.width
    spacing: mm

    Private.Loader {
        type: Attachment.Photo
        component: Photo {}
    }
    //Private.Loader {
    //    type: Attachment.Audio
    //    component: Audio {}
    //}
}
