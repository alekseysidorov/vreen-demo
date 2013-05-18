import QtQuick 2.0
import QtQuick.Controls 1.0

Item {
    id: page

    property Component header : backItem
    property Component footer
    property string title
    property string description
    property string iconSource

    function update() {
        console.log("SubPage::update - please implement this function in inheritors")
    }
}
