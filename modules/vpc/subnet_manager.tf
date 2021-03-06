resource "aws_subnet" "manager_subnet" {
  count             = var.manager_group_count
  vpc_id            = aws_vpc.vpc.id
  availability_zone = element(var.manager_subnet_zones, count.index)
  cidr_block        = element(var.manager_subnet_cidr, count.index)

  tags = {
    Name        = "${var.application}-manager-subnet-${count.index}"
    Application = var.application
  }
}

resource "aws_route_table_association" "manager_route_table_association" {
  count          = var.manager_group_count
  subnet_id      = element(aws_subnet.manager_subnet.*.id, count.index)
  route_table_id = aws_route_table.private_route.id
}