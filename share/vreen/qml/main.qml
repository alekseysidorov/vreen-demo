import QtQuick 2.0
import com.vk.api 1.0
import "components"
import QtDesktop 1.0
import QtQuick.Window 2.0

Item {
    id: app

    width: 800
    height: 800

    property Item currentPage: loginPage

    function centerize(item, width, height) {
        //item.x = (Screen.width - width) / 2;
        //item.y = (Screen.height - height) / 2;
        item.width = width;
        item.height = height;
    }

    onCurrentPageChanged: {
        //centerize(app, currentPage.implicitWidth, currentPage.implicitHeight);
    }

    //TODO use states
    Behavior on x {
        NumberAnimation { duration: 500 }
    }
    Behavior on y {
        NumberAnimation { duration: 500 }
    }
    Behavior on width {
        NumberAnimation { duration: 500 }
    }
    Behavior on height {
        NumberAnimation { duration: 500 }
    }

    LoginPage {
        id: loginPage

        implicitWidth: 400
        implicitHeight: 400

        anchors.fill: parent
        visible: currentPage == loginPage
        opacity: visible

        //TODO use states
        Behavior on opacity {
            NumberAnimation { duration: 500 }
        }
    }
    MainPage {
        id: mainPage

        implicitWidth: 800
        implicitHeight: 800

        anchors.fill: parent
        visible: currentPage == mainPage
        opacity: visible

        //TODO use states
        Behavior on opacity {
            NumberAnimation { duration: 500 }
        }
    }

    SystemPalette {
        id: syspal
    }

    Client {
        id: client

        onOnlineChanged: {
            if (online)
               currentPage = mainPage;
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
}
