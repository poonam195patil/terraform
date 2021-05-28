output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}

output "public_subnet_1_cidr" {
  value = aws_subnet.public_subnet_az_1.cidr_block
}

output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_az_1.id
}

output "public_subnet_2_cidr" {
  value = aws_subnet.public_subnet_az_2.cidr_block
}

output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_az_2.id
}

output "private_subnet_1_cidr" {
  value = aws_subnet.private_subnet_az_1.cidr_block
}

output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_az_1.id
}

output "private_subnet_2_cidr" {
  value = aws_subnet.private_subnet_az_2.cidr_block
}

output "private_subnet_2_id" {
  value = aws_subnet.private_subnet_az_2.id
}
output "vpc_security_group" {
  value = aws_vpc.security_group.id
}
