
output "vpc_id" {
    value = aws_vpc.main.id
    description = "returns the vpc unique id"
}

output "vpc_arn" {
    value = aws_vpc.main.arn
    description = "returns the aws resource name of the vpc"
}

output "public_subnet_ids" {
    value = aws_subnet.public_subnets[*].id
    description = "subnet id of public subnets"
}

output "private_subnet_ids" {
    value = aws_subnet.private_subnets[*].id
    description = "subnet id of private subnets"
}

