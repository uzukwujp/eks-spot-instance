
variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "karpenter_version" {
  type        = string
  description = "The version of karpenter"  
}

 variable "vpc_id" {
  type        = string
  description = "VPC ID"  
}

variable "cluster_security_group_id" {
  type        = string
  description = "EKS cluster security_group_id"  
}
