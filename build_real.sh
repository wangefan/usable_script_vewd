#!/bin/bash

input_param=$1

dir="Release_realtek"
if [ -z "$input_param" ] # not input 
then
  dir="Release_realtek"
  OUTDIR="out_gn_android_arm/${dir}"
  echo "build, version = Release, output path=${OUTDIR}"
  cd ../tvsdk
  ./android/tvgn --args tvsdk_official_build=true --args enable_realtek_hbbtv=true --args enable_mtk_hbbtv=false --args enable_uva_debug=true --args enable_hbbtv=true --args package_tvapp_example_sources=true --args package_tis_example_sources=true --outdir "$OUTDIR" use_goma=true && ninja -C "../chromium/src/$OUTDIR" -j800
else
  dir="Debug_realtek"
  OUTDIR="out_gn_android_arm/${dir}"
  echo "build, version = Debug, output path=${OUTDIR}"
  cd ../tvsdk
  ./android/tvgn -d --args tvsdk_official_build=true --args enable_realtek_hbbtv=true --args enable_mtk_hbbtv=false --args enable_uva_debug=true --args enable_hbbtv=true --args package_tvapp_example_sources=true --args package_tis_example_sources=true use_goma=true --outdir "$OUTDIR" && ninja -d -C "../chromium/src/$OUTDIR" -j800
fi
