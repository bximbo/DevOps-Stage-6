[app_servers]
todo-app-server ansible_host=${app_server_ip} ansible_user=${ssh_user} ansible_ssh_private_key_file=${ssh_key} ansible_python_interpreter=/usr/bin/python3

[app_servers:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
domain_name=${domain_name}
deploy_user=${deploy_user}
app_repo=${app_repo}
app_directory=/home/${deploy_user}/DevOps-Stage-6