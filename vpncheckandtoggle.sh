#!/bin/bash

helpFunction()
{
   echo ""
   echo "Usage: $0 -v VPN_PROFILE_NAME -a TOGGLE_STATUS"
   echo -e "\t-v VPN profile name (mandatory)"
   echo -e "\t-a Action to be perform. a) status, b) start, c) stop"
   exit 1 # Exit script after printing help
}

while getopts "v:a:" opt
do
   case "$opt" in
      v ) vpnProfileName="$OPTARG" ;;
      a ) action="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

if [ -z "$vpnProfileName" ]
then
   echo "VPN profile name is empty";
   helpFunction
fi

if [ -z "$action" ]
then
   let action="status"
fi


if nmcli con show --active | grep -i $vpnProfileName
then
   echo "VPN $vpnProfileName is up"
   if [ "$action" == "status" ]
   then
      exit 0
   fi
   if [ "$action" == "stop" ]
   then
      nmcli con down id $vpnProfileName
   fi
else
   echo "VPN $vpnProfileName is down"
   if [ "$action" == "status" ]
   then
      exit 1
   fi
   if [ "$action" == "start" ]
   then
      nmcli con up id $vpnProfileName
   fi
fi
exit 0
