variable "cluster_name" {
  type    = string
  default = "my-eks-cluster"
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

