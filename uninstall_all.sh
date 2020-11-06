#!/bin/bash                                                                                                                                     
echo "uninstall all apks..."
adb shell pm list packages | grep 'com\.vewd\.core\|com\.opera\.sdk' | cut -d':' -f2 | xargs -r -t -L1 adb shell pm uninstall
echo "uninstall all apks ok"
