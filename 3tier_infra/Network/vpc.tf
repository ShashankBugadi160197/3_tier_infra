#creating custom vpc  (Amazon Virtual Private Cloud)

resource "aws_vpc" "my_vpc" {

  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "My_VPC"
  }
}
