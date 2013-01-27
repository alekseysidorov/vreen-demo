cmake_minimum_required(VERSION 2.8.7)

project(vreen-demo)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(CommonUtils)

# Tell CMake to run moc when necessary:
set(CMAKE_AUTOMOC ON)
# As moc files are generated in the binary dir, tell CMake
# to always look for includes there:
set(CMAKE_INCLUDE_CURRENT_DIR ON)

# Widgets finds its own dependencies (QtGui and QtCore).
find_package(Qt5Core REQUIRED)
define_bundle_paths(vreen)
set(VREEN_IMPORTS_DIR ${BINDIR})

add_subdirectory(src/vreen)

add_simple_executable(vreen-demo
    SOURCE_DIR src/app
    QT Gui Quick
)

deploy_folder(share/vreen/qml
    DESTINATION ${SHAREDIR}/qml
    DESCRIPTION QML
)
