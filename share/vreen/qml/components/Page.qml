import QtQuick 2.0
import QtQuick.Window 2.0
import vreen.ui 1.0

Item {
    id: root

    // The status of the page. One of the following:
    //      PageStatus.Inactive - the page is not visible
    //      PageStatus.Activating - the page is transitioning into becoming the active page
    //      PageStatus.Active - the page is the current active page
    //      PageStatus.Deactivating - the page is transitioning into becoming inactive
    property int status: PageStatus.Inactive

    property PageStack pageStack

    // Defines orientation lock for a page
    property int orientationLock: PageOrientation.Automatic
    property Item tools: null

    visible: false

    width: visible && parent ? parent.width : internal.previousWidth
    height: visible && parent ? parent.height : internal.previousHeight

    onWidthChanged: internal.previousWidth = visible ? width : internal.previousWidth
    onHeightChanged: internal.previousHeight = visible ? height : internal.previousHeight

    // This is needed to make a parentless Page component visible in the Designer of QtCreator.
    // It's done here instead of binding the visible property because binding it to a script
    // block returning false would cause an element on the Page not to end up focused despite
    // specifying focus=true inside the active focus scope. The focus would be gained and lost
    // in createObject.
    Component.onCompleted: if (!parent) visible = true

    QtObject {
        id: internal
        property int previousWidth: 0
        property int previousHeight: 0

        function isScreenInPortrait() {
            return Screen.currentOrientation == Qt.Portrait || Screen.currentOrientation == Qt.PortraitInverted;
        }

        function isScreenInLandscape() {
            return Screen.currentOrientation == Qt.Landscape || Screen.currentOrientation == Qt.LandscapeInverted;
        }
    }
}
