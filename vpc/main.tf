provider "aws" {
  region = "ap-south-1"
  

}
terraform{
    backend "s3" {
        bucket  = "awsdevops-tf-state"
        key     = "env:/awsdevops/devvpc.tfstate"
        region  = "ap-south-1"
    
    }
}

# Creating VPC

resource "aws_vpc" "vpc" {
  cidr_block                       = var.vpc_cidr
  assign_generated_ipv6_cidr_block = false
  enable_dns_hostnames             = true

  tags = merge(
    var.tags,
    {
      Name = "${var.product}-${var.customer_name}-${var.env_name}-vpc"
    }
  )
}

resource "aws_internet_gateway" "igway" {
  depends_on = [
      aws_vpc.vpc
  ]
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.tags,
    {
      Name = "${var.product}-${var.customer_name}-${var.env_name}-igw"
    }
  )
}

data "aws_availability_zones" "available" {
  state = "available"
}

# Creating Public Subnets

resource "aws_subnet" "public_subnet_az_1" {
  depends_on = [
      aws_vpc.vpc
  ]
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr_az_1
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "${var.product}-${var.customer_name}-${var.env_name}-public-${data.aws_availability_zones.available.names[0]}"
      
    }
  )
}

resource "aws_subnet" "public_subnet_az_2" {
  depends_on = [
    aws_vpc.vpc
  ]
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr_az_2
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "${var.product}-${var.customer_name}-${var.env_name}-public-${data.aws_availability_zones.available.names[1]}"
      
    }
  )
}

# Creating Private Subnets

resource "aws_subnet" "private_subnet_az_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr_az_1
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = merge(
    var.tags,
    {
      Name = "${var.product}-${var.customer_name}-${var.env_name}-private-${data.aws_availability_zones.available.names[0]}"
      
    }
  )
}

resource "aws_subnet" "private_subnet_az_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr_az_2
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = merge(
    var.tags,
    {
      Name = "${var.product}-${var.customer_name}-${var.env_name}-private-${data.aws_availability_zones.available.names[1]}"
      "kubernetes.io/role/internal-elb"    = "1"
    }
  )
}



# Route Table for IGW

resource "aws_route_table" "route_public_subnet_1" {

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igway.id
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.product}-${var.customer_name}-${var.env_name}-public-rt-1"
    }
  )
}

resource "aws_route_table_association" "rta_public_1" {
  subnet_id      = aws_subnet.public_subnet_az_1.id
  route_table_id = aws_route_table.route_public_subnet_1.id
}

resource "aws_route_table" "route_public_subnet_2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igway.id}"
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.product}-${var.customer_name}-${var.env_name}-public-rt-2"
    }
  )
}

resource "aws_route_table_association" "rta_public_2" {
  subnet_id      = "${aws_subnet.public_subnet_az_2.id}"
  route_table_id = "${aws_route_table.route_public_subnet_2.id}"
}



