import qbs.base 1.0

Application {
    destination: "bin"
    name: "vreen-client"

    Depends { name: "qt"; submodules: ["core", "quick", "widgets"] }
    Depends { name: "cpp" }

    files: [
        "*.cpp",
        "*.h"
    ]

    Group {
        fileTagsFilter: product.type
        qbs.install: true
        qbs.installDir: "bin"
    }
}
