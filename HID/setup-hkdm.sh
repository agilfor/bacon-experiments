sudo rm -f /etc/hkdm/config.d/buttons.toml
sudo cp "$HOME/bacon-experiments/HID/buttons.toml" /etc/hkdm/config.d/
sudo chown root:root /etc/hkdm/config.d/buttons.toml
sudo chmod 644 /etc/hkdm/config.d/buttons.toml
sudo systemctl restart hkdm