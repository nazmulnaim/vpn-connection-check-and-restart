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
         echo "Sending ready status."
         systemd-notify --ready --status="Monitoring $vpnProfileName."
      else
         echo "Sending status update."
         systemd-notify --status="Monitoring $vpnProfileName"
      fi
   else
      echo "Exiting watchdog."
      exit 1
   fi
done
