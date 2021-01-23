resource "aws_subnet" "nat_subnet" {
  count             = var.nat_count
  vpc_id            = aws_vpc.vpc.id
  availability_zone = element(var.nat_subnet_zones, count.index)
  cidr_block        = element(var.nat_subnet_cidr, count.index)

  tags = {
    Name        = "${var.application}-nat-subnet-${count.index}"
    Application = var.application
  }
}

resource "aws_route_table_association" "nat_route_table_association" {
  count          = 1
  subnet_id      = element(aws_subnet.nat_subnet.*.id, count.index)
  route_table_id = aws_route_table.nat_route.id
}