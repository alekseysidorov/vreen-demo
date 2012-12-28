import QtQuick 2.0
import com.vk.api 1.0
import "components"

Item {
    id: root

    TextEdit {
        id: login

        onLinkActivated: client.connectToHost()

        anchors.centerIn: parent
        text: qsTr("<a href=\"http://vk.com\">Click to login</a>")
        textFormat: TextEdit.RichText
    }
}
