function contactLabel(from, owner, appendix) {
    if (!owner)
        return from.name;
    var str = qsTr("%1 ➜ %2").arg(owner.name).arg(from.name);
    if (appendix)
        str += "(" + appendix + ")";
    return str;
}
