#!/bin/bash

#variables 
config_path="/mnt/vendor/tvconfigs/hbbtv_fvp/vewd/"
config_file_src="config_tv_mds.json"
config_file="config.json"
config_file_backup="config_old.json"

echo "Step0: adb root, remount"
adb root
adb shell mount -o rw,remount /mnt/vendor/tvconfigs

echo "Step1: set dns"
adb shell "iptables -I OUTPUT -d 8.8.8.8 -j REJECT"

echo "Step2: stop all services..."
adb shell pm list packages | grep 'com\.vewd\.core' | cut -d':' -f2 | xargs -r -t -L1 adb shell am force-stop

echo "Step3: clear vos cache.."
adb shell pm clear com.vewd.core.service

echo "Step4: set FVP.."
adb shell setprop persist.fvp.capable.state 1
adb shell settings put secure fvp_tou_accepted_state 1

echo "Step5: Push config_tv_mds.json.."
# check if config.json exist.
check_result=$(adb shell "ls \"${config_path}${config_file_backup}\"")
echo "Step5-1: check if config.json exist, result = ${check_result}"
if [ -z "$check_result" ]; then  # not config_file_backup yet
    echo "Step5-2: not backup config yet, backup config.json to config_old.json"
    adb shell "mv \"${config_path}${config_file}\" \"${config_path}${config_file_backup}\""
    echo "Step5-3: push config.json.."
    adb push ${config_file_src} ${config_path}${config_file}
else  # already config_file_backup
    echo "Step5-2: has backed up and push my own config.json file, remove andpush again.."
    adb shell "rm -r \"${config_path}${config_file}\""
    echo "Step5-2: push files .."
    adb push ${config_file_src} ${config_path}${config_file}
fi

echo "Step6: stop all services..."
adb shell pm list packages | grep 'com\.vewd\.core' | cut -d':' -f2 | xargs -r -t -L1 adb shell am force-stop

echo "Step7: set up mds parameters.."
adb shell am broadcast -a com.vewd.core.service.SET_STARTUP_PARAMS -n com.vewd.core.service/.GlobalParamsReceiverForTesting -e args '"--disable-web-security --disable-auto-upgrade-mixed-content --unsafely-treat-insecure-origin-as-secure=\"http://image.fvcmd.test,http://ait.fvcmd.test,http://player.fvcmd.test,http://ctrl.fvcmd.test,http://metadata.fvcmd.test,http://metadata.fvcmds.test,http://metadata.fvcmds.net\""'

echo "Step8: Done, ready to scan channels, clientest if amber!"

#adb shell sync
#read -p "Press enter to reboot"
#adb reboot
