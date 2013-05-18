import qbs.base 1.0

Application {
    destination: "bin"
    name: "vreen-client"

    Depends { name: "Qt"; submodules: ["core", "quick", "widgets"] }
    Depends { name: "cpp" }
    Depends { name: "vreen.core" }

    files: [
        "*.cpp",
        "*.h"
    ]

    Group {
        fileTagsFilter: product.type
        qbs.install: true
        qbs.installDir: vreen.core.binDestination
    }
}
