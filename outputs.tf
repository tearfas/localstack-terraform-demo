output "instance_id_of_Jenkins_server" {
  description = "ID of the EC2 instance"
  value       = aws_instance.brightlab-localstack-Jenkins.id
}

output "instance_public_ip_of_the_Jenkins_Server" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.brightlab-localstack-Jenkins.public_ip
}

output "instance_id_of_AnsiCtrller" {
  description = "ID of the EC2 instance"
  value       = aws_instance.brightlab-localstack-Jenkins.id
}

output "instance_public_ip_of_Ansible_controller" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.brightlab-localstack-Jenkins.public_ip
}


output "instance_id_AnsiMgedNode" {
  description = "ID of the EC2 instance"
  value       = aws_instance.brightlab-localstack-Jenkins.id
}

output "instance_public_ip_of_the_Ansible_Mged_node1" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.brightlab-localstack-Jenkins.public_ip
}
