#!/bin/bash

# Script to set the battery charge limit on a laptop
# This script is supposed to be run as a systemd service

# Take the battery limit as an argument
limit=$1

# check if limit is provided
if [ -z $limit ]; then
    echo "Please provide the battery limit as an argument"
    exit 1
fi

if ! [[ $limit =~ ^[0-9]+$ ]] || [ $limit -lt 0 ] || [ $limit -gt 100 ]; then
    echo "Please provide a valid battery limit"
    exit 2
fi

battery=$(ls /sys/class/power_supply/ | grep BAT)

if [ -z $battery ]; then
    echo "No battery found"
    exit 3
fi

echo $limit | tee /sys/class/power_supply/$battery/charge_control_end_threshold

exit 0