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

echo "copy and install tvapp.apk, version = ${version}"

DIR=../chromium/src/out_gn_android_arm/${dir}

adb root
adb shell mount -o rw,remount /system
#adb install -r -d ${DIR}/apks/vewd-core-tvapp-release.apk
adb install -r -d ${DIR}/apks/vewd-core-tis-release.apk
adb install -r -d ${DIR}/apks/vewd-core-integration-release.apk
adb shell sync
read -p "Press enter to reboot"
adb reboot
