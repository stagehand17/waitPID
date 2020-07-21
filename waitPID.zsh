#!/bin/zsh
# waitPID.zsh
#
# Created by: David Madison Hardaway, Jr.
# Created on: July 20, 2020
# Updated July 21, 2020 using code from: http://blog.joncairns.com/2013/03/
# 	wait-for-a-unix-process-to-finish/ 
# Thank you Jon Cairns.

# Constants:
prompt="$(basename $0)($$):"

# Run as root:
if [[ $EUID -ne 0 ]]; then
	echo "This script should be run as root."
	exit 1
fi

# list active PIDs:
ps -la

# Get user input:
echo -n 'What is the PID of the process you would like to wait for?: ' 
read userpid

# handle input error
if [ -z "$userpid" ]
then
	echo "$prompt a valid PID is required as input" >&2
	exit 2
fi

echo -n 'What would you like to do after this process finishes?: ' 
read usercommand

# Make a pretty name variable
name=$(ps -p $userpid -o comm=)

# The workhorse code:
if [ $? -eq 0 ]
then
	echo "$prompt waiting for PID $userpid to finish ($prompt)"
	while ps -p $userpid > /dev/null; do sleep 1; done;
else
		echo "$prompt failed to find process with PID $userpid" >&2
		exit 1
fi

eval $usercommand

#EOF
