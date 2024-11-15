
variable "chart_version" {
  type        = string
  description = "The exact helm chart version of argocd"  
}

variable "custom_values" {
  type        = string
  description = "path to the custom helm values file"
  default     = ""  
}