

# TEST #
# ------------- List objects

# user1-ap is access point name / user2-ap is access point name

# aws s3api list-objects-v2 --bucket arn:aws:s3:ap-southeast-1:747913987992:accesspoint/user1-ap

#-------------- Put objects

# mkdir test.txt
# aws s3api put-object --bucket arn:aws:s3:ap-southeast-1:747913987992:accesspoint/user1-ap --key test.txt


#-------------------------- Create EC2 test

# Find Linux Server ec2
data "aws_ami" "amazon-linux" {
  owners = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

# Create Linux Server and install/enable Jenkins ec2
resource "aws_instance" "test-ap" {

  ami = data.aws_ami.amazon-linux.id
  instance_type = "t2.micro"
  key_name = "test"
  iam_instance_profile = aws_iam_instance_profile.user2_profile.id
  security_groups = [ "${aws_security_group.ssh-sg.id}" ]

  tags = {
    Name  = "test"
  }
}



resource "aws_security_group" "ssh-sg" {
  description = "Allow jenkins inbound traffic"
  #vpc_id      = aws_vpc.prod-vpc.id

# Inbound Rules
  ingress {
    description      = "SSH : Allow SSH from Personal CIDR block"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/16"]
  }

# Outbound Rules
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh-sg"
  }
}
