
#create internat gateway for servers to be connected to internet

resource "aws_internet_gateway" "my_ig" {
  tags = {
    name = "MY_IGW"

  }
  vpc_id     = aws_vpc.my_vpc.id
  depends_on = [aws_vpc.my_vpc]

}

#add default route in routing table to point to internet gateway

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.my_route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_ig.id
}
