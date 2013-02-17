import QtQuick 2.0

Loader {
    property variant model
    property Component component

    onLoaded: {
        item.model = model;
    }

    sourceComponent: model ? component : null
}
