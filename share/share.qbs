import qbs.base 1.0

Product {
    type: "installed_content"

    Depends { name: "vreen.core" }

    Group {
        qbs.installDir: qbs.targetOS === 'mac' ? "vreen-client.app/Contents/Resources" : "bin"
        //qbs.install: true
        fileTags: ['install', 'qml']
        overrideTags: false

        files: "vreen/qml"
    }
}
