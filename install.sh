#!/bin/bash

# Script to add the battery-limit service to systemd and set the battery limit to argument
# This script is supposed to be run as root

if [ $EUID -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# check if limit is provided
if [ -z $1 ]; then
    echo "Please provide the battery limit as an argument"
    exit 2
fi

if ! [[ $1 =~ ^[0-9]+$ ]] || [ $1 -lt 40 ] || [ $1 -gt 100 ]; then
    echo "Please provide a valid battery limit"
    exit 3
fi

echo "Copying set-battery-limit.sh to /usr/local/bin"
cp set-battery-limit.sh /usr/local/bin/set-battery-limit -f
chmod +x /usr/local/bin/set-battery-limit

echo "Copying battery-limit.service to /etc/systemd/system"
cp battery-limit.service /etc/systemd/system/battery-limit.service -f

echo "Setting battery limit to $1%"
sed -i "s/BATTERY_LIMIT/$1/g" /etc/systemd/system/battery-limit.service

echo "Reloading systemd daemon"
systemctl daemon-reload

echo "Enabling battery-limit service"
systemctl enable battery-limit

echo "Starting battery-limit service"
systemctl start battery-limit

echo "Battery limit set to $1%"

exit 0