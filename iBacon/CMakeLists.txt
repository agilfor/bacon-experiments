cmake_minimum_required(VERSION 3.16)
project(iBacon)

# Turn on Qt's magic meta-object compiler
set(CMAKE_AUTOMOC ON)

find_package(Qt6 COMPONENTS Core Gui Qml REQUIRED)

add_executable(springboard main.cpp launcher.h)
target_link_libraries(springboard PRIVATE Qt6::Core Qt6::Gui Qt6::Qml)