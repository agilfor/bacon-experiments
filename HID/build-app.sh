rm -rf build/
cmake -B build
cmake --build build
sudo cp build/payload-app /usr/local/bin/
sudo systemctl restart payload-ui.servic