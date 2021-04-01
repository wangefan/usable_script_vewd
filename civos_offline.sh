#!/bin/bash

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

echo "Step4: Push files.."
adb shell mv '/data/data/com.vewd.core.service/browser_home/contexts/OS/Service\ Worker/' '/data/data/com.vewd.core.service/browser_home/contexts/OS/Service\ Worker_old/'
adb push ${image_path}/OS/Service\ Worker/ /data/data/com.vewd.core.service/browser_home/contexts/OS/
adb shell chmod 777 "/data/data/com.vewd.core.service/browser_home/contexts/OS/Service\ Worker/"

echo "Step5: delete worker files.."
rm -r ./${image_path}

echo "Step6: Done"

#adb shell sync
#read -p "Press enter to reboot"
#adb reboot
