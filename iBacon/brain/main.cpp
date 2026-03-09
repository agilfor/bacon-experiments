#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "launcher.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    
    // Inject our custom C++ Launcher into the QML engine as "System"
    Launcher sys;
    engine.rootContext()->setContextProperty("System", &sys);
    
    // Load your masterpiece
    engine.load(QUrl::fromLocalFile("/home/$USER/bacon-experiments/iBacon/SpringBoard.qml"));
    if (engine.rootObjects().isEmpty()) return -1;
    
    return app.exec();
}