variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/24" #251 usable IP addresses
}

variable "private_subnet1_cidr" {
  description = "CIDR block for the first private subnet"
  type        = string
  default     = "10.0.1.0/27" #27 usable IP addresses
}

variable "private_subnet2_cidr" {
  description = "CIDR block for the second private subnet"
  type        = string
  default     = "10.0.2.0/27" #27 usable IP addresses
}

variable "availability_zone1" {
  description = "Availability Zone for the first subnet"
  type        = string
  default     = "us-east-1a" 
}

variable "availability_zone2" {
  description = "Availability Zone for the second subnet"
  type        = string
  default     = "us-east-1b" 
}
