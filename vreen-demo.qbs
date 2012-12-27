import qbs.base 1.0

Project {   
    moduleSearchPaths: ["qbs/modules", 'src/vreen/modules']

    references: [
        "src/vreen/src/3rdparty/k8json/k8json.qbs",
        "src/vreen/src/api.qbs",
        "src/vreen/src/qml/qml.qbs",
        "src/vreen/src/oauth/oauth.qbs",
        "src/vreen/src/directauth/directauth.qbs",
        "src/app/app.qbs",
        "share/share.qbs"
    ]
}
