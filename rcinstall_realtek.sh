#!/bin/bash

# reset package
./reset.sh

./cinstall_realtek.sh $1

echo "reboot the device then install the APK"
