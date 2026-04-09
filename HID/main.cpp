#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDir>
#include "runner.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    
    Runner sys;
    engine.rootContext()->setContextProperty("System", &sys);
    
    QString qmlPath = QDir::homePath() + "/bacon-experiments/HID/Main.qml";
    engine.load(QUrl::fromLocalFile(qmlPath));

    QString lockQmlPath = QDir::homePath() + "/bacon-experiments/HID/LockScreen.qml";
    engine.load(QUrl::fromLocalFile(lockQmlPath));

    if (engine.rootObjects().isEmpty()) return -1;
    
    return app.exec();
}