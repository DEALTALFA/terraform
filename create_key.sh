
if [ "$(uname -o)" == "GNU/Linux" ]
then
	#create private and pub key
	ssh-keygen -t rsa -m pem -f "private"
else
	echo "Not a Linux System"
fi


: '
	covert pem to ppk then run below command
	puttygen private -o private.ppk -O private   
	
	covert ppk to pem .run below command
	puttygen private.ppk -O private-openssh -o pemkey.pem

'	
# if want to run the command copy and paste in your terminal
