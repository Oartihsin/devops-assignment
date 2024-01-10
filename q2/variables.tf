variable "access_key" {
  description = "AWS access key"
  default = "null"
}
variable "secret_key" {
  description = "AWS secret key"
  default = "null"
}

variable "region" {
  description = "AWS region"
  default     = "us-east-1"  
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  default     = "rattle-eks" 
}

