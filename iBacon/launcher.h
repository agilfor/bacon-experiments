#pragma once
#include <QObject>
#include <QProcess>
#include <QString>

class Launcher : public QObject {
    Q_OBJECT
public:
    // Q_INVOKABLE makes this function visible to the QML frontend
    Q_INVOKABLE void launch(const QString &cmd) {
        QProcess::startDetached(cmd);
    }
};