
function contactLabel(from, owner, appendix) {
    if (!owner)
        return from.name;
    var str = qsTr("%2\n ← %1").arg(owner.name).arg(from.name);
    if (appendix)
        str += "(" + appendix + ")";
    return str;
}

function formatDate(date) {
    var info = Qt.formatDateTime(date, qsTr("dddd in hh:mm"));
    return info;
}
