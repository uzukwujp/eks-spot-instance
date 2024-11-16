variable "cluster_name" {
  type = string  
}

variable "private_subnet_ids" {
  type = list(string)  
}

variable "cluster_role_name" {
  type = string 
}

variable "cluster_version" {
  type = string  
}