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
