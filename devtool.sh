#!/bin/bash
echo "stop all services..."
adb shell pm list packages | grep 'com\.vewd\.core\|com\.opera\.sdk' | cut -d':' -f2 | xargs -r -t -L1 adb shell am force-stop
echo "stop all services ok"

adb forward tcp:9222 localabstract:tvsdk-debugging-socket 
echo "set debug socket ok"

adb forward tcp:9222 localabstract:tvsdk-debugging-socket 
echo "set debug socket ok"

adb shell am broadcast -a com.vewd.core.service.SET_STARTUP_PARAMS -n com.vewd.core.service/.GlobalParamsReceiverForTesting -e args '--remote-debugging-socket-name=tvsdk-debugging-socket' 
echo "SET_STARTUP_PARAMS ok"
