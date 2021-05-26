#!/bin/bash

#create private and pub key
[ "$(uname -o)" == "GNU/Linux" ] && ssh-keygen -t rsa -m pem -f "private"
[ "$(uname -o)" == "GNU/Linux" ] || echo "Not a Linux System" && \
	read -p "Is it window system (yes/no)??" reply && \
       	[ $reply == "yes" ] && ssh-keygen


: '
	covert pem to ppk then run below command
	puttygen private -o private.ppk -O private   
	
	covert ppk to pem .run below command
	puttygen private.ppk -O private-openssh -o pemkey.pem

'	
# if want to run the command anyway copy and paste in your terminal
