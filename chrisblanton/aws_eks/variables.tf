
variable "region" {
    description = "AWS Region"
    type = string
    default = "us-east-1"
}


locals {
  cluster_name = "education-eks-${random_string.suffix.result}"
}

