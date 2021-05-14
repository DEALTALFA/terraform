sudo mkfs.ext4 /dev/xvdb
sudo mount /dev/xvdb /var/www/html
sudo yum install git -y
sudo git clone https://github.com/DEALTALFA/test2.git /var/www/html
sudo yum install httpd -y
sudo yum enable httpd --now     
