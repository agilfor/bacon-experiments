#!/bin/sh

DIR=$(pwd)
# Navigate to the postmarketOS USB gadget directory
cd /sys/kernel/config/usb_gadget/g1

# 1. Turn off the USB port temporarily
echo "" | tee UDC

# 2. Create the HID keyboard interface
mkdir -p functions/hid.usb0
echo 1 > functions/hid.usb0/protocol
echo 1 > functions/hid.usb0/subclass
echo 8 > functions/hid.usb0/report_length

# 3. Write the raw hex USB Keyboard Descriptor
echo -ne "\x05\x01\x09\x06\xa1\x01\x05\x07\x19\xe0\x29\xe7\x15\x00\x25\x01\x75\x01\x95\x08\x81\x02\x95\x01\x75\x08\x81\x03\x95\x05\x75\x01\x05\x08\x19\x01\x29\x05\x91\x02\x95\x01\x75\x03\x91\x03\x95\x06\x75\x08\x15\x00\x25\x65\x05\x07\x19\x00\x29\x65\x81\x00\xc0" > functions/hid.usb0/report_desc

# 4. Attach the keyboard to the active USB configuration
ln -s functions/hid.usb0 configs/c.1/

# 5. Turn the USB port back on
ls /sys/class/udc | tee UDC

cd $DIR

echo "HID Keyboard Mode Enabled! (/dev/hidg0 is ready)"