# >>> tells which provider to use >>>
provider "aws"{
region="ap-south-1"
shared_credentials_file= "credential.txt"
}
# <<< INTFRASTRUCTURE CODE BELOW <<<

# >>>which key to use >>>
resource "aws_key_pair" "deployer" {
key_name = "terraform-key"
  public_key = file("private.pub") #starting with ssh-rsa
}
# <<< key created <<<

# >>> creating SecurityGroup for the instance >>>
resource "aws_security_group" "mysg" {
  name        = "sg_for_TF"
  description = "Allow all inbound and outbound traffic"
  vpc_id      = "vpc-b1f919da"

  ingress {
    description      = "allow all to incoming traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
/* when -1(all protocol) is  specifed it allows traffic on all ports, regardless of any port range you specify */
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description = "allow all to outgoing traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = " allow all traffic for TF"
  }
}
# <<< SG creation completed for instance <<<

# >>> creating a instance on aws >>>
resource "aws_instance" "web" {
  ami           = "ami-010aff33ed5991201"
  instance_type = "t2.micro"
  ebs_block_device {
        device_name ="/dev/sdb"
        volume_size = "1"
        volume_type = "gp2"
                }
  key_name = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.mysg.name]
  tags = {
    Name = "web for TF"
  }
}
# <<< creating instance finished <<<

#only for testing purpose
output "output_of_instance" {
value = aws_instance.web
}

# >>> making connection with the instance on the cloud and running commands >>>
resource "null_resource" "run"{
 connection {
        type = "ssh"
        user = "ec2-user"
        private_key = file("private")
        host = aws_instance.web.public_ip
}
 provisioner "remote-exec"{
        inline=[
        "sudo yum install httpd -y",
        "sudo systemctl enable httpd --now",
        "sudo mkfs.ext3 /dev/xvdb",
        "sudo mount /dev/xvdb /var/www/html",
        "sudo yum install git -y",
        "sudo git clone https://github.com/DEALTALFA/test2.git /var/www/html/web"
		]
	}
}
# <<< connection complete <<<
