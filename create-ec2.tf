resource "aws_security_group" "ec2_security_group" {
  name        = "ec2_security_group"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc-id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_instance_profile" "EC2InstanceProfile" {
  name = "EC2InstanceProfile"
  role = aws_iam_role.IamEC2Role.name
}

resource "aws_instance" "ec2_instance" {
  ami           = var.ami-id
  instance_type = "t2.micro"

  iam_instance_profile = aws_iam_instance_profile.EC2InstanceProfile.name
  security_groups      = [aws_security_group.ec2_security_group.name]

  tags = {
    Name = "MyEC2Instance"
  }
  # Add key_name if you want to SSH into the instance
  key_name = "access-sshkey-pair"  # Replace with your key pair name
}

