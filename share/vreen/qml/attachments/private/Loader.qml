import QtQuick 2.0
import Vreen.Base 2.0

Loader {
    property int type
    property Component component

    enabled: allowedTypes.indexOf(type) !== -1

    onLoaded: {
        item.model = Qt.binding(function() { return model[type]; });
    }

    sourceComponent: (enabled && model && model[type]) ? component : null
}
