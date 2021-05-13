#create private and pub key
ssh-keygen -t rsa -m pem -f private.pem
#pem to ppk
puttygen private.pem -o private.ppk -O private
#ppk to pem
puttygen private.ppk -O private-openssh -o pemkey.pem

