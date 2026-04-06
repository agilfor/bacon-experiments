cmake_minimum_required(VERSION 3.16)
project(payload-app VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick)

qt_add_executable(payload-app
    main.cpp
)

qt_add_qml_module(payload-app
    URI PayloadUI
    VERSION 1.0
    QML_FILES Main.qml
)

target_link_libraries(payload-app PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)