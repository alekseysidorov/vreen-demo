import qbs.base 1.0

Project {   
    moduleSearchPaths: ["qbs/modules", 'src/vreen/qbs/modules']

    references: [
        "src/vreen/vreen.qbs",
        "src/app/app.qbs",
        "share/share.qbs"
    ]
}
