#pragma once
#include <QObject>
#include <QProcess>
#include <QString>
#include <QCryptographicHash>
#include <fcntl.h>
#include <unistd.h>
#include <linux/input.h>
#include <sys/ioctl.h>
#include <cstring>

class Launcher : public QObject {
    Q_OBJECT
    int vib_fd = -1;
    struct ff_effect effect;

public:
    Launcher() {
        // 1. Open the vibrator device
        vib_fd = open("/dev/input/event0", O_RDWR | O_NONBLOCK);
        if (vib_fd >= 0) {
            // 2. Define the iOS-style "Click" (15ms rumble)
            memset(&effect, 0, sizeof(effect));
            effect.type = FF_RUMBLE;
            effect.id = -1; // Let the kernel assign an ID
            effect.u.rumble.strong_magnitude = 0xFFFF; // 100% motor speed
            effect.u.rumble.weak_magnitude = 0x0000;
            effect.replay.length = 30;
            effect.replay.delay = 0;
            
            // 3. Upload the effect to the hardware memory
            ioctl(vib_fd, EVIOCSFF, &effect);
        }
    }

    ~Launcher() {
        if (vib_fd >= 0) close(vib_fd);
    }

    Q_INVOKABLE void launch(const QString &cmd) {
        QString swayCommand = QString("workspace 2; exec %1").arg(cmd);
        QProcess::startDetached("swaymsg", {swayCommand});
    }

    // NEW: The Haptic Trigger
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