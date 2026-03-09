#pragma once
#include <QObject>
#include <QProcess>
#include <QString>

class Launcher : public QObject {
    Q_OBJECT
public:
    Q_INVOKABLE void launch(const QString &cmd) {
        QString swayCommand = QString("workspace 2; exec %1").arg(cmd);
        QProcess::startDetached("swaymsg", {swayCommand});
    }
};