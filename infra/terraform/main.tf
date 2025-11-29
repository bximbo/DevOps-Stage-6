terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}

provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Project     = "TODO-App"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = var.owner_email
    }
  }
}

# Data source to get latest Ubuntu 22.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Create key pair from provided public key
resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = var.ssh_public_key
}

# Create EC2 instance
resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer.key_name  # Use the created key pair

  vpc_security_group_ids = [aws_security_group.app_sg.id]

  root_block_device {
    volume_size           = var.volume_size
    volume_type          = "gp3"
    delete_on_termination = true
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              hostnamectl set-hostname todo-app-server
              EOF

  tags = {
    Name = "todo-app-server"
  }

  lifecycle {
    ignore_changes = [
      user_data,
      ami
    ]
  }
}

# Elastic IP
resource "aws_eip" "app_eip" {
  instance = aws_instance.app_server.id
  domain   = "vpc"

  tags = {
    Name = "todo-app-eip"
  }
}

# Generate Ansible inventory file
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.tpl", {
    app_server_ip = aws_eip.app_eip.public_ip
    ssh_user      = var.ssh_user
    ssh_key       = var.ssh_private_key_path
    domain_name   = var.domain_name
  })
  filename = "${path.module}/../ansible/inventory/hosts"

  depends_on = [aws_eip.app_eip]
}

# Trigger Ansible after infrastructure is ready
resource "null_resource" "run_ansible" {
  triggers = {
    instance_id = aws_instance.app_server.id
    eip_id      = aws_eip.app_eip.id
  }

  provisioner "local-exec" {
    command = <<-EOT
      echo "Waiting for server to be ready..."
      sleep 90
      
      echo "Testing SSH connection..."
      ssh -o StrictHostKeyChecking=no -i ${var.ssh_private_key_path} ${var.ssh_user}@${aws_eip.app_eip.public_ip} "echo 'SSH connection successful'"
      
      echo "Running Ansible playbook..."
      cd ${path.module}/../ansible
      ansible-playbook -i inventory/hosts playbook.yml -v
    EOT
  }

  depends_on = [
    local_file.ansible_inventory,
    aws_eip.app_eip
  ]
}