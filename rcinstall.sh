#!/bin/bash

# reset package
./reset.sh

./cinstall.sh $1

echo "reboot the device then install the APK"
