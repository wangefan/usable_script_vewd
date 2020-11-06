#!/bin/bash
echo "stop all services..."
adb shell pm list packages | grep 'com\.vewd\.core\|com\.opera\.sdk' | cut -d':' -f2 | xargs -r -t -L1 adb shell am force-stop
echo "stop all services ok"
