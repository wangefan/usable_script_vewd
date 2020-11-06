#!/bin/sh                                                                                                                                      
P=../chromium/src/out_gn_android_arm/Debug/apks
adb shell mount -o remount,rw /
adb shell mkdir -p /system/priv-app/com.vewd.core.tis
adb shell mkdir -p /system/priv-app/com.vewd.core.service
adb shell mkdir -p /system/priv-app/com.vewd.core.tvapp
#adb shell mkdir -p /system/priv-app/com.vewd.core.test
adb shell mkdir -p /system/priv-app/VewdCoreIntegration
adb push ${P}/vewd-core-tvapp-release.apk /system/priv-app/com.vewd.core.tvapp
adb push ${P}/vewd-core-tis-release.apk /system/priv-app/com.vewd.core.tis
adb push ${P}/vewd-core-service-release.apk /system/priv-app/com.vewd.core.service
#adb push ${P}/vewd-core-test-release.apk /system/priv-app/com.vewd.core.test
adb push ${P}/vewd-core-integration-release.apk /system/priv-app/VewdCoreIntegration
#adb push ${P}/vewd-core-integration-debug-androidTest.apk /system/priv-app/VewdCoreIntegration
