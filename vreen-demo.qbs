import qbs.base 1.0

Project {   
    property string vreen_client_bin_path: "bin"
    property string vreen_client_qml_path: "bin"
    property string vreen_client_resources_path: "share"

    Properties {
        condition: qbs.targetOS.contains("osx")
        vreen_client_qml_path: vreen_client_bin_path + "/vreen-client.app/Contents/MacOS"
        vreen_client_resources_path: vreen_client_bin_path + "/vreen-client.app/Contents/Resources"
    }

    qbsSearchPaths: ["qbs", 'src/vreen']

    references: [
        "src/src.qbs",
        "share/share.qbs"
    ]
}
