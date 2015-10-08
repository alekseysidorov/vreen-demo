import qbs.base 1.0

Product {
    name: "qmlContent"
    type: "installed_content"

    Depends { name: "vreen" }

    Group {
        name: "qml"
        qbs.installDir: vreen_client_resources_path
        qbs.install: true
        fileTags: ['qml']
        overrideTags: false
        files: "vreen/qml"
    }

    Group {
        name: "dummy"

        files: "vreen/qml/**"
    }
}
