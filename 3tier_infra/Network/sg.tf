#create a security group

resource "aws_security_group" "app_sg" {
  name        = "App_SG"
  description = "Allow Web Inbound Traffic"
  vpc_id      = aws_vpc.my_vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #open to everyone
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #open to everyone
  }

  egress { #egress means to access return calls
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #open to everyone
  }
}
