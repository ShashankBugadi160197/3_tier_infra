#define routing table

resource "aws_route_table" "my_route-table" {
  tags = {
    name = "My_Route-Table"
  }
  vpc_id = aws_vpc.my_vpc.id
}

#associate subnet with routing table

resource "aws_route_table_association" "App_Route_Association" {

  subnet_id      = aws_subnet.my_app-subnet.id
  route_table_id = aws_route_table.my_route-table.id

}
