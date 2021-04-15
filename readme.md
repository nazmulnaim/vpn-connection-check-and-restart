This is a simple script to monitor the VPN connection with VPN profile name and re-initiate the connection again.  

Need to clone the repo
```
git clone URL
cd vpn-checker-and-toggler-ubuntu
```
Need to execute command with sudo permission to prepare the environment
```
sudo mkdir /usr/lib/vpncheckandtoggle
 
sudo cp vpn-watchdog.sh /usr/lib/vpncheckandtoggle/

sudo cp vpncheckandtoggle.sh /usr/lib/vpncheckandtoggle/
 
sudo chmod +x /usr/lib/vpncheckandtoggle/vpn-watchdog.sh

sudo chmod +x /usr/lib/vpncheckandtoggle/vpncheckandtoggle.sh
 
sudo cp vpnmonitor@.service /lib/systemd/system/

```
Start the monitory service
```
systemctl enable vpnmonitor@VPN_PROFILE_NAME.service

systemctl start vpnmonitor@VPN_PROFILE_NAME.service
```

To stop the monitory service
```
systemctl stop vpnmonitor@VPN_PROFILE_NAME.service
```

Need to replace VPN_PROFILE_NAME with the one which needs to be monitored.