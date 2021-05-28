
variable "instance_type" {
    default = "t2.micro"
}


variable "instance_ami" {
    default = "ami-0c1a7f89451184c8b"
}

variable "key_name" {
    default = "kajukey"
}



#variable "ami_count" {}



variable "vpc_remote_state_bucket" {
    description = "Bucket name for remote state"
    default = "awsdevops-tf-state"
}

variable "vpc_remote_state_key" {
    description = "Key name for layer 1 remote state"
    //    default = "layer1/production.tfstate"
    default = "devvpc.tfstate"
}

variable "region" {
    description = "AWS Region"
    default     = "ap-south-1"
}


