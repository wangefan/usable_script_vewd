#/bin/bash      

input_param=$1
version="-release"
dir="Release"
if [ -z "$input_param" ] # not input 
then
  version="-release"
  dir="Release_realtek"
else
  version="-debug"
  dir="Debug_realtek"
fi

echo "rtk update, version = ${version}"

DIR=../chromium/src/out_gn_android_arm/${dir}

adb root
adb shell mount -o rw,remount /system
adb push ${DIR}/apks/vewd-core-service-release.apk /system/priv-app/VewdCoreService/VewdCoreService.apk
adb push ${DIR}/lib.java/vewdcore-service-dex.jar /system/framework/vewdcore-service-dex.jar
adb push ${DIR}/lib.java/vewdcore-shared-dex.jar /system/framework/vewdcore-shared-dex.jar
adb push ${DIR}/lib.java/vewdcore-client-dex.jar /system/framework/vewdcore-client-dex.jar
adb push ${DIR}/libs/vewdcore-client-fvp-dex.jar /system/framework/vewdcore-client-fvp-dex.jar

#adb push ${DIR}/apks/vewd-core-integration-release.apk /system/priv-app/VewdCoreService/vewd-core-integration-release.apk
#adb shell pm install /system/priv-app/VewdCoreService/vewd-core-integration-release.apk
adb install -r -d ${DIR}/apks/vewd-core-integration-release.apk

adb shell sync
read -p "Press enter to reboot"
adb reboot
