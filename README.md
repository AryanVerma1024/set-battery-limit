# Battery Limit Service

This project provides a systemd service to set the battery charge threshold on a laptop. It includes scripts to install and configure the service.

## Files

- `battery-limit.service`: The systemd service file.
- `install.sh`: Script to install the service and set the battery limit.
- `set-battery-limit.sh`: Script to set the battery charge limit.

## Installation

1. Clone the repository or download the files.
2. Run the `install.sh` script as root with the desired battery limit as an argument.

```bash
chmod +x install.sh
sudo ./install.sh <BATTERY_LIMIT>
```

Replace `<BATTERY_LIMIT>` with a value between 40 and 100.

## Usage

The service will automatically set the battery limit to the specified value. You can check the status of the service using:

## Uninstallation

To remove the service and the scripts, run the following commands:

```sh
sudo systemctl stop battery-limit
sudo systemctl disable battery-limit
sudo rm /etc/systemd/system/battery-limit.service
sudo rm /usr/local/bin/set-battery-limit
sudo systemctl daemon-reload
```
