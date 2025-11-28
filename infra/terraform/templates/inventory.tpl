resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.tpl", {
    app_server_ip = aws_eip.app_eip.public_ip
    ssh_user      = "ubuntu"
    ssh_key       = var.ssh_private_key_path
    domain_name   = var.domain_name
    path          = path.module
  })

  filename = "${path.module}/../ansible/inventory/hosts"

  depends_on = [aws_eip.app_eip]
}