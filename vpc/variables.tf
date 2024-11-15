
variable "cidr_block"  {
    type = string
    default = "10.0.0.0/16"
}

variable "instance_tenancy" {
    type = string
    default = "default"
}

variable "enable_dns_hostnames"  {
    type = bool
    default = "true"
}

variable "tag" {
    type = string
    default = "testing"
}

variable "az_count" {
  default = 2
}

variable "cluster_name" {
    type = string
    description = "name of the cluster"  
}
