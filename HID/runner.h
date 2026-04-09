#pragma once
#include <QObject>
#include <QProcess>
#include <QDebug>

class Runner : public QObject {
    Q_OBJECT
public:
    explicit Runner(QObject *parent = nullptr) : QObject(parent) {}

    Q_INVOKABLE void click() {
        if (vib_fd >= 0 && effect.id != -1) {
            struct input_event play;
            memset(&play, 0, sizeof(play));
            play.type = EV_FF;
            play.code = effect.id;
            play.value = 1; // 1 = Play the effect
            write(vib_fd, (const void*)&play, sizeof(play));
        }
    }

    Q_INVOKABLE void fire() {
        qDebug() << "Executing payload script...";
        QProcess::startDetached("/bin/sh", {"-c", "/usr/local/bin/payload-calc.sh"});
    }

    Q_INVOKABLE bool verifyPin(const QString &pin) {
        // The SHA-256 hash for the PIN "1234"
        QString correctHash = "03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4";
        
        // Hash whatever the user just typed
        QString inputHash = QCryptographicHash::hash(pin.toUtf8(), QCryptographicHash::Sha256).toHex();
        
        if (inputHash == correctHash) {
            // Correct PIN! Tell Sway to drop the lock screen.
            QProcess::startDetached("swaymsg", {"workspace back_and_forth"});
            return true;
        }
        return false;
    }
};