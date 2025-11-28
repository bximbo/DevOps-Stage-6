# AWS / General Configuration
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-north-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "owner_email" {
  description = "Email of the infrastructure owner"
  type        = string
  default     = "israelabimbolaa@gmail.com"
}

# Compute / EC2
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}

variable "volume_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 25
}

# SSH Configuration
variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "todo-app-key"
}

variable "ssh_public_key" {
  description = "SSH public key content"
  type        = string
}

variable "ssh_private_key_path" {
  description = "Path to SSH private key for Ansible"
  type        = string
  default     = "~/.ssh/todo-app-key"
}

variable "ssh_user" {
  description = "Username for SSH"
  type        = string
  default     = "ubuntu"
}

# Networking / Security
variable "allowed_ssh_cidr" {
  description = "CIDR blocks allowed to SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# Application
variable "domain_name" {
  description = "Domain name for the application"
  type        = string
  default     = "israelabimbola.com"
}

variable "deploy_user" {
  description = "User for deploying the application"
  type        = string
  default     = "deploy"
}

variable "app_repo" {
  description = "Git repository for the application"
  type        = string
  default     = "https://github.com/israeladenuga/DevOps-Stage-6.git"
}
