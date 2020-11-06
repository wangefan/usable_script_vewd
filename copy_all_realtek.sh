#!/bin/bash

LibP=../chromium/src/out_gn_android_arm/Release_realtek/lib.java
adb root
adb shell mount -o rw,remount /system
echo "push jar..."
adb push ${LibP}/vewdcore-client.jar   /system/framework/vewdcore-client.jar
adb push ${LibP}/vewdcore-service.jar   /system/framework/vewdcore-service.jar
adb push ${LibP}/vewdcore-shared.jar   /system/framework/vewdcore-shared.jar

echo "push dex..."
adb push ${LibP}/vewdcore-client-dex.jar   /system/framework/
adb push ${LibP}/vewdcore-service-dex.jar   /system/framework/
adb push ${LibP}/vewdcore-shared-dex.jar   /system/framework/

echo "push service apk..."
adb push ../chromium/src/out_gn_android_arm/Release_realtek/apks/vewd-core-service-release.apk /system/priv-app/VewdCoreService/VewdCoreService.apk
adb shell sync
adb shell reboot

echo "done! rebooting.."
