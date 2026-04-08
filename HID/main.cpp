#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDir>
#include "launcher.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    
    Launcher sys;
    engine.rootContext()->setContextProperty("System", &sys);
    
    // THE FIX: Dynamically build the path using QDir::homePath()
    QString qmlPath = QDir::homePath() + "/bacon-experiments/HID/Main.qml";
    engine.load(QUrl::fromLocalFile(qmlPath));
    
    if (engine.rootObjects().isEmpty()) return -1;
    
    return app.exec();
}