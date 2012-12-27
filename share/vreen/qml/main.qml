import QtQuick 2.0
import com.vk.api 1.0
import "components"
import QtDesktop 1.0

Item {
    id: app

    width: 600
    height: 800

    PageStack {
        id: stack
        anchors.fill: parent
        initialPage: loginPage
    }

    SystemPalette {
        id: syspal
    }

    Client {
        id: client

        onOnlineChanged: {
            if (online)
               stack.replace(dialogsPage);
        }

        connection: conn
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

    LoginPage {
        id: loginPage
    }
    DialogsPage {
        id: dialogsPage
    }
}
