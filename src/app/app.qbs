import qbs.base 1.0

Application {
    destination: "bin"
    name: "vreen-client"

    Depends { name: "qt"; submodules: ["core", "quick"] }
    Depends { name: "cpp" }

    files: [
        "*.cpp",
        "*.h"
    ]
}
