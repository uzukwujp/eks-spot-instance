

resource "aws_eip" "nats" {
  count    =  var.az_count
  domain   = "vpc"
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "nats" {
  count         = var.az_count
  allocation_id = aws_eip.nats[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id

  tags = {
    Name = var.tag
  }
}

