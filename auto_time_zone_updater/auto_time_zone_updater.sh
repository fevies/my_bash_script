#!/bin/bash

#uses kdialog on kde(FEDORA) to add a desktop noification

#List timezone API endpoints
declare -a providers=(
	"https://ipapi.co/timezone"
	"https://ipinfo.io/timezone"
	"http://worldtimeapi.org/api/ip.txt"
	)

TIMEZONE=""

for provider in "${providers[@]}"; do
	TIMEZONE=$(curl -s "provider" | xargs) #xargs strips whitespace
	if [[ -n "$TIMEZONE" ]]; then
	break
	fi
done

#Handle case when all fail
if [[ "$TIMEZONE" == "$CURRENT_TZ" ]]; then
	kdialog --title "Timezone check" --passivepopup "Time zone is set to $TIMEZONE."
	exit 0
fi
#set the timezone
sudo timedatectl set-timezone "$TIMEZONE"

#Notify the user
kdialog --title --passivepopup "Timezone changed to $TIMEZONE."i



