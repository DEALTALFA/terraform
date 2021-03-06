#!/bin/bash

if [ "$(uname -o)" == "GNU/Linux" ]
then
	#create private and pub key
	ssh-keygen -t rsa -m pem -f "private"
else
	echo "Not a Linux System"
	read -p "Is it window system (yes/no)??" reply
	if (( $reply == "yes" ))
	then
		ssh-keygen
	fi
fi


: '
	covert pem to ppk then run below command
	puttygen private -o private.ppk -O private   
	
	covert ppk to pem .run below command
	puttygen private.ppk -O private-openssh -o pemkey.pem

'	
# if want to run the command anyway copy and paste in your terminal
