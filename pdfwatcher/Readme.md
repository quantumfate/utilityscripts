# My Systemd Service
This script sets up a Systemd service that monitors the ~/Downloads directory for new PDFs. When a new PDF is downloaded, the script opens it with Okular and adds it to a list of downloaded PDFs. On system startup, the script will delete all of the PDFs listed in this file.

To set up the Systemd service, copy the following code into a file named my-systemd-service.service and save it in the /etc/systemd/system/ directory:

```bash
[Unit]
Description=My Systemd Service

[Service]
Type=simple
ExecStart=/path/to/my/script.sh

[Install]
WantedBy=multi-user.target
```
Replace `/path/to/my/script.sh` with the actual path to the script on your system.

To start the service, run the following command:

`systemctl start my-systemd-service.service`

To enable the service to automatically start on system boot, run the following command:

`systemctl enable my-systemd-service.service`

You can use the following command to check the status of the service:

`systemctl status my-systemd-service.service`

You can use the following command to stop the service:

`systemctl stop my-systemd-service.service`

You can use the following command to disable the service from starting automatically on system boot:

`systemctl disable my-systemd-service.servic`
