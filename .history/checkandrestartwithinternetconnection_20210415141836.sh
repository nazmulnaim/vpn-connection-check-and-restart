#!/bin/bash

while getopts "v:a:" opt
do
   case "$opt" in
      v ) vpnProfileName="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

if [ -z "$vpnProfileName" ]
then
   echo "VPN profile name is not given.";
   exit 1
fi

sleep 5
firstRun="1"

while true ; do
   if nmcli con show --active | grep -i $vpnProfileName
   then
      if [ "$firstRun" == "1" ]
      then
         firstRun="0"
         echo "VPN is up."
      else
         echo "VPN is up."
      fi
      ping -c1 google.com
      if [ $? -eq 0 ]
      then 
         echo "Internet is working."
      else
         echo "Internet is not working, restarting..."
         nmcli con down id $vpnProfileName
         sleep 5
         nmcli con up id $vpnProfileName
      fi
   else
      if [ "$firstRun" == "1" ]
      then
         firstRun="0"
         nmcli con up id $vpnProfileName
         echo "VPN is up."
      else
         nmcli con up id $vpnProfileName
         echo "Restarting VPN...."
      fi
   fi
   sleep 10
done
