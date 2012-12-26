import qbs.base 1.0

Product {
    type: "installed_content"

    Group {
        fileTags: "install"
        qbs.installPrefix: qbs.targetOS === 'mac' ? "vreen-demo.app/Contents/Resources" : "bin"
        files: "vreen/qml"
    }
}
