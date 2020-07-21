#!/bin/zsh
# waitPID.zsh
#
# Created by: David Madison Hardaway, Jr.
# Created on: July 20, 2020

if [[ $EUID -ne 0 ]]; then
	echo "This script should be run as root."
	exit 1
fi

ps -la

echo -n 'What is the PID of the process you would like to wait for?: ' 
read -n 5 userpid

echo -n 'What would you like to do after this process finishes?: ' 
read usercommand

echo "Now waiting on your process to complete.\n"
while [[ -d /proc/$userpid ]]
	do sleep 1
done

$usercommand

#EOF
