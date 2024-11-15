
variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "custom_policy_document" {
  description = "The JSON policy document for the role"
  type        = string
}
