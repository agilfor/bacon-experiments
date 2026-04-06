# bacon-experiments

Just a repository to keep track of stuff I'm working on with a OnePlus One loaded with a postmarketOS distribution of Linux.

## iBacon

This is just a spin-off project to see how far one can get trying to build a lightweight UI to be as lightweight as possible while still looking professional.

To run you will need to run the following commands inside `iBacon`:  
`cmake .`  
`make`  

To get it to work with systemd and load on bootup:  
`sudo ln -s /absolute/path/to/sprinboard@.service /etc/systemd/system/springboard@.service`  
`sudo systemctl daemon-reload`  
`sudo systemctl enable --now springboard@$USER`  

Logs can be checked through:  
`journalctl -u springboard@$USER -f`  

To reload the service after making changes:  
`sudo systemctl restart springboard@$USER`  

### Notes

Permissions are a fairly important thing for this kind of project. `swipe.sh` will need a `chmod +x` permissions applied to it, and to have haptic feedback it could be necessary to run `sudo chmod 666 /dev/input/event0`

## HID

A simple tool that makes the bacon act as a HID device (specifically a keyboard), allowing it to send payloads to devices connected over USB. This is for testing and educational purposes only.

To run this the kernel needs to be properly built. Ensure that when building the kernel, `CONFIG_USB_CONFIGFS_F_HID` is enabled.

It is best to have this repository directly in `$HOME`, as otherwise you will run into path issues.

Commands to get the USB port to act like a keyboard:  
`sudo ln -s /absolute/path/to/button.toml /etc/hkdm/config.d/buttons.toml` (only run once)  
`sudo systemctl enable --now hkdm` (only run once)  
`sudo ~/path/to/enable-hid.sh` (run after every reboot)  

### Notes

It is important that the SSH session is run over Wi-Fi and not over USB, as otherwise in running the `enable-hid.sh` script you also lose control of the device. The Wi-Fi IP address will be displayed on TTY1.
