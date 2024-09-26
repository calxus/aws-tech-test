data "aws_availability_zones" "current" {}

resource "aws_vpc" "poc" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_subnet" "poc_public" {
  count                   = local.availability_zones
  vpc_id                  = aws_vpc.poc.id
  cidr_block              = "172.16.${count.index + 10}.0/24"
  availability_zone_id    = data.aws_availability_zones.current.zone_ids[count.index]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "poc_private" {
  count                = local.availability_zones
  vpc_id               = aws_vpc.poc.id
  cidr_block           = "172.16.${count.index + 20}.0/24"
  availability_zone_id = data.aws_availability_zones.current.zone_ids[count.index]
}

resource "aws_route_table" "poc_public" {
  count  = local.availability_zones
  vpc_id = aws_vpc.poc.id
}

resource "aws_route_table" "poc_private" {
  count  = local.availability_zones
  vpc_id = aws_vpc.poc.id
}

resource "aws_route_table_association" "poc_public" {
  count          = local.availability_zones
  route_table_id = aws_route_table.poc_public[count.index].id
  subnet_id      = aws_subnet.poc_public[count.index].id
}

resource "aws_route_table_association" "poc_private" {
  count          = local.availability_zones
  route_table_id = aws_route_table.poc_private[count.index].id
  subnet_id      = aws_subnet.poc_private[count.index].id
}

resource "aws_internet_gateway" "poc" {
  vpc_id = aws_vpc.poc.id
}

resource "aws_eip" "poc" {
  count = local.availability_zones
}

resource "aws_nat_gateway" "poc" {
  count         = local.availability_zones
  allocation_id = aws_eip.poc[count.index].id
  subnet_id     = aws_subnet.poc_public[count.index].id

  depends_on = [aws_internet_gateway.poc]
}

resource "aws_route" "poc_public" {
  count                  = local.availability_zones
  route_table_id         = aws_route_table.poc_public[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.poc.id
}

resource "aws_route" "poc_private" {
  count                  = local.availability_zones
  route_table_id         = aws_route_table.poc_private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.poc[count.index].id
}