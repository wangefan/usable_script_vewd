#!/bin/bash

input_param=$1
version="-release"
dir="Release"
if [ -z "$input_param" ] # not input 
then
  version="-release"
  dir="Release"
else
  version="-debug"
  dir="Debug"
fi

echo "cinstall, version = ${version}"

DIR=../chromium/src/out_gn_android_arm/${dir}/apks

# names of examples you want to install
#examples_names=( "service" "tis" "tvapp" "fvpplayer" "fvpsign" "hbbtv" "integration" )
examples_names=( "service" "tis" "tvapp" "integration" "browserui")

function _cmd() {
  echo $1
  $1
  return $?
}

setup_device() {
  echo "setup_device"
  _cmd "adb shell mount -o remount,rw /"
}

get_name0() {
  echo "com.vewd.core.${examples_names[$1]}"
}

get_name1() {
  local fw_ver=$(adb shell getprop ro.build.description)
  if [[ $fw_ver == *"ISOPHI"* || $fw_ver == *"winston-user"* ]]; then
    echo "$(get_name0 $1).fvp"
  else
    echo "$(get_name0 $1)"
  fi
}

get_name2() {
  echo "vewd-core-${examples_names[$1]}${version}"
}

install() {
  for ((i = 0; i < ${#examples_names[@]}; ++i)); do
    local apk_file="${DIR}/$(get_name2 i).apk"
    if [ ! -f "${apk_file}" ]; then
      echo "${apk_file} does not exist! Ignoring."
      continue
    fi

    echo ""
    _cmd "adb shell mkdir -p /system/priv-app/$(get_name1 i)"
    _cmd "adb shell chmod 755 /system/priv-app/$(get_name1 i)"
    _cmd "adb shell chown root:root /system/priv-app/$(get_name1 i)"
    _cmd "adb push ${apk_file} /system/priv-app/$(get_name1 i)/$(get_name1 i).apk"
    _cmd "adb shell chmod 644 /system/priv-app/$(get_name1 i)/$(get_name1 i).apk"
    _cmd "adb shell pm install -r /system/priv-app/$(get_name1 i)/$(get_name1 i).apk"
    echo "install $(get_name1 i).apk ok"
  done

  _cmd "adb shell sync"
}

main() {
  ./stop_all_service.sh
  setup_device
  install
}

main "${@}"

echo "Done."
