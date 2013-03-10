
function contactLabel(from, owner, comment) {
    if (!owner)
        return from.name;
    if (comment)
        comment += "\n"
    var str = "%2\n%3← %1".arg(owner.name).arg(from.name).arg(comment);
    return str;
}

function formatDate(date) {
    var info = Qt.formatDateTime(date, qsTr("dddd in hh:mm"));
    return info;
}

function checkProperty(value, def) {
    if (def === undefined)
        def = null;
    return value === undefined ? def : value;
}
