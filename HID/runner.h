#pragma once
#include <QObject>
#include <QProcess>
#include <QDebug>

class Runner : public QObject {
    Q_OBJECT
public:
    explicit Runner(QObject *parent = nullptr) : QObject(parent) {}

    Q_INVOKABLE void fire() {
        qDebug() << "Executing payload script...";
        QProcess::startDetached("/bin/sh", {"-c", "/usr/local/bin/payload-calc.sh"});
    }
};