#!/bin/bash

input_param=$1

dir="Release"
if [ -z "$input_param" ] # not input 
then
  dir="Release"
  OUTDIR="out_gn_android_arm/${dir}"
  echo "build, version = Release, output path=${OUTDIR}"
  cd ../tvsdk
  ./android/tvgn use_goma=true && ninja -C ../chromium/src/$OUTDIR -j 800 tvsdk tvsdk-qa
else
  dir="Debug"
  OUTDIR="out_gn_android_arm/${dir}"
  echo "build, version = Debug, output path=${OUTDIR}"
  cd ../tvsdk
  ./android/tvgn -d use_goma=true && ninja -C ../chromium/src/$OUTDIR -j 800 tvsdk tvsdk-qa
fi



