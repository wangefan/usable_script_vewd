#!/bin/bash

#variables 
sw_root_path="/data/data/com.vewd.core.service/browser_home/contexts/OS/"
sw="Service Worker/"
backup="Service Worker_old/"

echo "Step1:stop all services..."
#adb shell pm list packages | grep 'com\.vewd\.core\|com\.opera\.sdk' | cut -d':' -f2 | xargs -r -t -L1 adb shell am force-stop
adb root

echo "Step2: find VOS image zip files.."
cd ..
zip_path=$(grep --include=*.zip -irl ./)
echo "zip path=${zip_path}"

# todo: add if
echo "Step3: Extract files.."
unzip ${zip_path}
image_path=$(find . -name 'vosFwImage*' -type d)
echo "image_path = ${image_path}"

echo "Step4: Push files.. "
# check if service worker exist.
check_result=$(adb shell "ls \"${sw_root_path}${backup}"\")
echo "check_result = ${check_result}"
if [ -z "$check_result" ]; then  # not backup yet
    echo "Step4-1: Backup original to browser_home/contexts/OS/Service Worker_old"
    adb shell "mv \"${sw_root_path}${sw}\" \"${sw_root_path}${backup}\""
    echo "Step4-2: push files .."
	echo "XXXXXXXXXX path=${image_path}/OS/${sw}"
    adb push "${image_path}/OS/${sw}" "${sw_root_path}"
    #adb shell chmod 777 "/data/data/com.vewd.core.service/browser_home/contexts/OS/Service\ Worker/"
else  # already backup
    echo "Step4-1: delete previous service worker files.."
    adb shell "rm -r \"${sw_root_path}${sw}\""
    echo "Step4-2: push files .."
    adb push "${image_path}/OS/${sw}" "${sw_root_path}"
fi

echo "Step5: delete worker files.."
rm -r ./${image_path}

echo "Step6: Done"

#adb shell sync
#read -p "Press enter to reboot"
#adb reboot
