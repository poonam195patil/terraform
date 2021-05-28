
variable "product" {
     default ="EC"
}
variable "customer_name" {
     default = "abc"
}
variable "env_name" {
     default = "development"
}

variable "vpc_cidr" { 
    default = "192.168.0.0/16" 
}

variable "public_subnet_count" { default = 2 }

variable "public_subnet_cidr_az_1" {
     default = "192.168.1.0/24"
}
variable "public_subnet_cidr_az_2" {
     default = "192.168.2.0/24"
}
variable "private_subnet_cidr_az_1" {
     default = "192.168.3.0/24"
}
variable "private_subnet_cidr_az_2" {
     default = "192.168.4.0/24"
}

variable "tags" { 
    type = map 
    default = {
    Environment = "dev"
    
  }
}
