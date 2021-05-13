provider "aws"{
region="ap-south-1"
}

resource "aws_key_pair" "deployer" {
key_name = "terraform-key"
  public_key = <your public key>
  
  }

resource "aws_security_group" "mysg" {
  name        = "sg_for_TF"
  description = "Allow all inbound and outbound traffic"
  vpc_id      = "vpc-b1f919da"

  ingress {
    description      = "allow all to incoming traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"          
/* -1 to specify all protocols .allows traffic on all ports, regardless of any port range you specify */
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


resource "aws_instance" "web" {
  ami           = "ami-010aff33ed5991201"
  instance_type = "t2.micro"
  ebs_block_device {
	device_name="/dev/sdb"
	volume_size = "1"
	volume_type= "gp2"
		}
  key_name= aws_key_pair.deployer.key_name
  security_groups=[aws_security_group.mysg.name]
  tags = {
    Name = "web for TF"
  }
}
output "output_of_instance" {
value= aws_instance.web
}
