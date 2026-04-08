#pragma once
#include <QFileSystemWatcher>
#include <QFile>
#include <QObject>
#include <QString>
#include <fcntl.h>
#include <unistd.h>
#include <linux/input.h>
#include <cstring>
#include <sys/ioctl.h>

class Launcher : public QObject {
    Q_OBJECT
    int vib_fd = -1;
    struct ff_effect effect;

public:
    Launcher() {
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

    ~Launcher() {
        if (vib_fd >= 0) close(vib_fd);
    }

signals:
    void sleepTriggered();
};