Project {
    name: "src"

    references: [ "app/app.qbs", ]

    SubProject {
        filePath: "vreen/vreen.qbs"

        Properties {
            vreen_qml_path: vreen_client_qml_path
            name: "vreen-imported"
        }
    }
}
