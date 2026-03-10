#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDir>         // <-- Add this!
#include "launcher.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    
    Launcher sys;
    engine.rootContext()->setContextProperty("System", &sys);
    
    // THE FIX: Dynamically build the path using QDir::homePath()
    QString qmlPath = QDir::homePath() + "/bacon-experiments/iBacon/SpringBoard.qml";
    engine.load(QUrl::fromLocalFile(qmlPath));

    QString lockPath = QDir::homePath() + "/bacon-experiments/iBacon/LockScreen.qml";
    engine.load(QUrl::fromLocalFile(lockPath));
    
    if (engine.rootObjects().isEmpty()) return -1;
    
    return app.exec();
}