import QtQuick 2.0
import com.vk.api 1.0

Loader {
    property int type
    property Component component

    enabled: allowedTypes.indexOf(type) !== -1

    onLoaded: {
        item.model = Qt.binding(function() { return model[type]; });
    }

    sourceComponent: enabled && model[type] ? component : null
}
