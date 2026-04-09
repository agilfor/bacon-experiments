#pragma once
#include <QFileSystemWatcher>
#include <QFile>
#include <QObject>
#include <QProcess>
#include <QString>
#include <QCryptographicHash>
#include <fcntl.h>
#include <unistd.h>
#include <linux/input.h>
#include <sys/ioctl.h>
#include <cstring>

class Runner : public QObject {
    Q_OBJECT
    int vib_fd = -1;
    struct ff_effect effect;

public:
    Runner() {
        // --- 1. Vibration Setup ---
        vib_fd = open("/dev/input/event0", O_RDWR | O_NONBLOCK);
        if (vib_fd >= 0) {
            memset(&effect, 0, sizeof(effect));
            effect.type = FF_RUMBLE;
            effect.id = -1;
            effect.u.rumble.strong_magnitude = 0xFFFF;
            effect.u.rumble.weak_magnitude = 0x0000;
            effect.replay.length = 30;
            effect.replay.delay = 0;
            ioctl(vib_fd, EVIOCSFF, &effect);
        }
        // --- 2. IPC Sleep Bridge Setup ---
        QFile file("/tmp/sleep_event");
        if (file.open(QIODevice::WriteOnly)) {
            file.close();
        }
        QFileSystemWatcher *watcher;
        watcher = new QFileSystemWatcher(this);
        watcher->addPath("/tmp/sleep_event");
        connect(watcher, &QFileSystemWatcher::fileChanged, this, [this]() {
            emit sleepTriggered();
        });
    }

    ~Runner() {
        if (vib_fd >= 0) close(vib_fd);
    }

signals:
    void sleepTriggered();

public slots:
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