#!/bin/bash

#declare -i ID

#ID=`xinput list | grep -Eo 'Touch\s*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'`

#declare -i STATE

#STATE=`xinput list-props $ID|grep 'Device Enabled'|awk '{print $4}'`
#if [ $STATE -eq 1 ]
#then
#    xinput disable $ID
#    echo "Touchpad disabled."
#else
#    xinput enable $ID
#    echo "Touchpad enabled."
#fi

TOUCHPAD_ID=$(xinput | grep "ALP0011:00 044E:120C" | awk -F'=' '{print $2}' | awk -F' ' '{print $1}')

echo "Touchpad ID is $TOUCHPAD_ID"

state=$(xinput list-props "$TOUCHPAD_ID" | grep "Device Enabled" | grep -o "[01]$")

if [ $state == '1' ];then
  xinput --disable $TOUCHPAD_ID
  echo "Touchpad is disabled."
else
  xinput --enable $TOUCHPAD_ID
  echo "Touchpad is enabled"
fi
