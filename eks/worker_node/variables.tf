
variable "node_group_name" {
  type = string 
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "desired_size" {
  type = number
}

variable "max_size" {
  type = number 
}

variable "min_size" {
  type = number 
}

variable "max_unavailable" {
  type = number
}

variable "cluster_name" {
  type = string
}

variable "worker_node_iam_role_name" {
  type = string 
}

variable "instance_types" {
  type = list(string)
  default = ["t3.medium"] 
}

variable "capacity_type" {
  type = string
  default = "ON_DEMAND" 
}

variable "kubernetes_version" {
  type        = string
  description = "The kubernetes version"  
}