# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "demo" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  
  tags = tomap({
    "Name" = "dotpay-dev-demonode"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared",
  })
}

resource "aws_subnet" "public" {
  count                   = "${length(var.subnet_cidr)}"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.20.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = "${aws_vpc.demo.id}"

  tags = tomap({
    "Name" = "dotpay-dev-demonode"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
  })
}
resource "aws_subnet" "private" {
  count                   = "${length(var.subnet_cidr)}"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "${element(var.subnet_cidr, count.index)}"      #"10.20.${count.index}.0/24"
  map_public_ip_on_launch = false
  vpc_id                  = "${aws_vpc.demo.id}"

  tags = tomap({
    "Name" = "dotpay-dev-demonode"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
  })
}


resource "aws_internet_gateway" "demo" {
  vpc_id = "${aws_vpc.demo.id}"

  tags = {
    Name = "dotpay-dev-demo"
  }
}


resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.demo.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo.id
  }
}


resource "aws_route_table" "private" {
  count = "${length(var.subnet_cidr)}"
  vpc_id = aws_vpc.demo.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }
}


resource "aws_route_table_association" "public" {
  count = 2
  subnet_id      = aws_subnet.public.*.id[count.index]
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "private" {
  count = "${length(var.subnet_cidr)}"
  subnet_id = aws_subnet.public.*.id[count.index]
  route_table_id = aws_route_table.private.id
}
  
  
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.demo]
}
resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id     = "${element(aws_subnet.public.*.id, 0)}"
  depends_on    = [aws_internet_gateway.demo]
  tags = {
    Name        = "nat"
  }
}
