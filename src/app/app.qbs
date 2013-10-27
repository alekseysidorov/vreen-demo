import qbs.base 1.0

Application {
    destinationDirectory: vreen_client_bin_path
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
        qbs.installDir: vreen_client_bin_path
    }
}
