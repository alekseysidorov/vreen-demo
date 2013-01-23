import QtQuick 2.0
import com.vk.api 1.0
import "components"
import QtDesktop 1.0
import QtQuick.Window 2.0

PageStackWindow {
    id: app
    Component.onCompleted: client.connectToHost()

    initialPage: newsPage
    sideBar: sideBar
    width: 1024
    height: 800
    visible: true
    title: qsTr("Vreen demo client - %1").arg(pageStack.currentPage.title)

    SideBar {
        id: sideBar

        anchors.fill: parent

        items: [
            NewsPage {
                id: newsPage
            },
            FriendsPage {

            },
            DialogsPage {
                id: dialogsPage
            },
            AudioPage {
                id: audioPage
            }
        ]
    }

    Client {
        id: client
        connection: conn

        onOnlineChanged: {
            if (online && pageStack.currentPage) {
                pageStack.currentPage.update();
                roster.sync();
            }
        }
    }

    OAuthConnection {
        id: conn

        Component.onCompleted: {
            setConnectionOption(Connection.ShowAuthDialog, true);
            setConnectionOption(Connection.KeepAuthData, true);
        }

        clientId: 3220807
        displayType: OAuthConnection.Popup
    }
}
