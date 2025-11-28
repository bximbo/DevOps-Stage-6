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
  description = "SSH username for the server"
  type        = string
  default     = "ubuntu"
}

variable "allowed_ssh_cidr" {
  description = "CIDR blocks allowed to SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

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
  default     = "https://github.com/bximbo/DevOps-Stage-6.git"
}

variable "owner_email" {
  description = "Email of the infrastructure owner"
  type        = string
  default     = "israelabimbolaa@gmail.com"
}