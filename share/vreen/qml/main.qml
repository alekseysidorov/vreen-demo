import QtQuick 2.0
import com.vk.api 1.0
import "components"
import QtDesktop 1.0
import QtQuick.Window 2.0

ApplicationWindow {
    id: app

    width: 800
    height: 800
    visible: true

    property Item currentPage: loginPage
    property Item previousPage

    function replace(item) {
        previousPage = currentPage;
        currentPage = item;
    }

    function showPage(item) {
        currentPage.anchors.fill = container;
        if (previousPage) {
            container.state = "prepare";
            container.state = "ready";
        }
    }

    onCurrentPageChanged: {
        showPage(currentPage);
    }

    Component.onCompleted: {
        currentPage.visible = true;
        showPage(currentPage);
    }

    Rectangle {
        id: container

        anchors.fill: parent

        LoginPage {
            id: loginPage

            implicitWidth: 400
            implicitHeight: 400
            visible: false
        }
        MainPage {
            id: mainPage

            implicitWidth: 800
            implicitHeight: 800
            visible: false
        }

        states: [
            State {
                name: "prepare"
                PropertyChanges {
                    target: previousPage
                    visible: true
                    opacity: 1
                }
                PropertyChanges {
                    target: currentPage
                    visible: false
                    opacity: 0
                }
            },
            State {
                name: "ready"
                PropertyChanges {
                    target: previousPage
                    visible: false
                    opacity: 0
                }
                PropertyChanges {
                    target: currentPage
                    visible: true
                    opacity: 1
                }
                //PropertyChanges {
                //    target: app
                //    width: currentPage.implicitWidth
                //    height: currentPage.implicitHeight
                //}
            }
        ]

        transitions: [
            Transition {
                from: "prepare"
                to: "ready"

                SequentialAnimation {
                    ScriptAction { scriptName: "centerizeApp" }
                    NumberAnimation {
                        target: app.previousPage;
                        properties: "opacity"
                        duration: 300;
                        easing.type: Easing.InOutQuad
                    }
                    //NumberAnimation {
                    //    target: app
                    //    properties: "x,y,width,height"
                    //    duration: 250
                    //    easing.type: Easing.InOutQuad
                    //}
                    NumberAnimation {
                        target: app.currentPage;
                        properties: "opacity"
                        duration: 300;
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        ]
    }

    SystemPalette {
        id: syspal
    }

    Client {
        id: client

        onOnlineChanged: {
            if (online)
                replace(mainPage);
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
