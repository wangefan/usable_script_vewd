#/bin/bash      
address=$1                                                                                                                               
IP=10.112.32.
if [ -z "$address" ] # not input 
then
  IP="${IP}65" #default use 65
else
  IP="${IP}${address}"
fi
echo "connect to ${IP}"

#IP=10.112.32.77
#IP=10.32.49.254
#IP=192.168.1.101
adb connect ${IP};
adb root;
adb connect ${IP};
adb shell setenforce 0
adb shell getenforce
adb shell mount -o remount,rw /
#adb shell "su 0 echo TEST > /sys/power/wake_lock"
#adb shell "su 0 cat /sys/power/wake_lock"
#adb shell svc power stayon true
#adb shell "su 0 echo 10.112.32.26 hbbtv1.test hbbtv2.test hbbtv3.test a.hbbtv1.test b.hbbtv1.test c.hbbtv1.test >> /etc/hosts"
#adb shell "su 0 cat /etc/hosts"
