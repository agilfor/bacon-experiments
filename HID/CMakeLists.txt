cmake_minimum_required(VERSION 3.16)
project(HID)

# Turn on Qt's magic meta-object compiler
set(CMAKE_AUTOMOC ON)

find_package(Qt6 COMPONENTS Core Gui Qml REQUIRED)

add_executable(HID-app main.cpp runner.h)
target_link_libraries(HID-app PRIVATE Qt6::Core Qt6::Gui Qt6::Qml)