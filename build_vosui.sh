#!/bin/bash

input_param=$1

dir="Release_vosui"
if [ -z "$input_param" ] # not input 
then
  dir="Release_vosui"
  OUTDIR="out_gn_android_arm/${dir}"
  echo "build, version = Release, output path=${OUTDIR}"
  cd ../tvsdk
  ./android/tvgn --arch=arm --args tvsdk_official_build=true --args tvapp_config_variant=\"offline\" --args embed_vos_offline=true  --args tvstore_recommendations=false --args enable_realtek_hbbtv=false --outdir "$OUTDIR" && ninja -d keeprsp -C "../chromium/src/$OUTDIR" -j 800 tvsdk
else
  dir="Debug_vosui"
  OUTDIR="out_gn_android_arm/${dir}"
  echo "build, version = Debug, output path=${OUTDIR}"
  cd ../tvsdk
  ./android/tvgn -d --arch=arm --args tvsdk_official_build=true --args tvapp_config_variant=\"offline\" --args embed_vos_offline=true  --args tvstore_recommendations=false --args enable_realtek_hbbtv=false --outdir "$OUTDIR" && ninja -d keeprsp -C "../chromium/src/$OUTDIR" -j 800 tvsdk tvsdk-qa
fi
