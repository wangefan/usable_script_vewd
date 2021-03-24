#!/bin/bash                                                                                                                                     

adb shell setenforce 0
adb shell getenforce
adb shell mount -o remount,rw /
adb shell mount -o remount,rw /system
echo "list current com.vewd.core.* packages.."
adb shell pm list packages | grep 'com\.vewd\.core\|com\.opera\.sdk' | cut -d':' -f2 | xargs -r -t -L1

./stop_all_service.sh

echo "clear all com.vewd.core.* ..."
adb shell pm list packages | grep 'com\.vewd\.core\|com\.opera\.sdk' | cut -d':' -f2 | xargs -r -t -L1 adb shell pm clear 
adb shell rm -rf '/system/priv-app/com.vewd.*'
adb shell rm -rf '/system/priv-app/VewdCoreService' # only for RTK project

echo "syncing..."
adb shell sync

./uninstall_all.sh
