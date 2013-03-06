import qbs.base 1.0

Product {
    name: "qmlContent"

    Depends { name: "vreen.core" }

    Group {
        qbs.installDir: qbs.targetOS === 'mac' ? "vreen-client.app/Contents/Resources" : "bin"
        qbs.install: true
        fileTags: ['qml']
        overrideTags: false
        files: "vreen/qml"
    }
}
