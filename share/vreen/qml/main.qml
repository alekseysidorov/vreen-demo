import QtQuick 2.0
import Vreen.Base 2.0
import "components"
import QtQuick.Controls 1.0
import QtQuick.Window 2.0

PageStackWindow {
    id: app

    Component.onCompleted: {
        client.connectToHost();
        visibility = "Maximized";
    }

    initialItem: sideBar.currentItem
    sideBar: side
    width: 1024
    height: 800
    title: qsTr("Vreen demo client - %1").arg(stackView.currentPage ? stackView.currentPage.title : qsTr("unknown"))

    SideBar {
        id: side

        anchors.fill: parent

        currentItem: newsPage

        NewsPage { id: newsPage }
        ProfilePage { id: myProfilePage; title: qsTr("Profile") }
        FriendsPage {}
        DialogsPage { id: dialogsPage }
        AudioPage { id: audioPage }
    }

    Component {
        id: backItem
        Item {

            Text {
                text: stackView.currentItem ? stackView.currentItem.title : ""
                anchors {
                    left: parent.left
                    margins: 2*mm
                    verticalCenter: parent.verticalCenter
                }
            }

            Button {
                id: backButton

                onClicked: stackView.pop()

                text: qsTr("Back")

                anchors {
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                }
            }
        }
    }

    //subpages
    PostPage { id: postPage }
    ProfilePage {
        id: profilePage
        header: backItem
    }

    Client {
        id: client
        connection: conn

        onOnlineChanged: {
            if (online) {
                roster.sync();
                if (stackView.currentItem)
                    stackView.currentItem.update();
            } else
                connectToHost(); //temporary hack
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
