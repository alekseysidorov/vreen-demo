import qbs.base 1.0

Application {
    destination: "bin"
    name: "vreen-demo"

    Depends { name: "qt"; submodules: ["core", "quick"] }
    Depends { name: "cpp" }
    Depends { name: "vreen.imports" }

    files: [
        "*.cpp",
        "*.h"
    ]
}
