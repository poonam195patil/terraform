provider "aws" {
  region = "ap-south-1"
  

}
terraform{
    backend "s3" {
        bucket  = "awsdevops-tf-state"
        key     = "env:/awsdevops/devec2.tfstate"
        region  = "ap-south-1"
        
    }
}

//Remote States
data "terraform_remote_state" "network_configuration" {
    backend = "s3"
    workspace = "awsdevops"
    config = {
        bucket = var.vpc_remote_state_bucket
        key    = var.vpc_remote_state_key
        region = var.region
    }
}
resource "aws_instance" "webapp" {
  
  instance_type = var.instance_type
  ami = var.instance_ami
  key_name = var.key_name
  #vpc_id = data.terraform_remote_state.network_configuration.outputs.vpc_id
  subnet_id = data.terraform_remote_state.network_configuration.outputs.public_subnet_1_id
  security_groups = data.terraform_remote_state.network_configuration.outputs. vpc_security_group_id
  root_block_device {
    volume_size = "8"
    volume_type = "gp2"
    encrypted = "true"
  }
}
