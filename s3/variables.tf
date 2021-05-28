variable "bucket_name" {
    description = "S3 bucket creation"
    default = "awsdevops-tf-state"
}

variable "tags" { 
    type = map

  default = {
    Environment = "dev"
    Dept        = "study"
  }
}
