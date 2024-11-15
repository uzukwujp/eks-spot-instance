
output "endpoint" {
  value = aws_eks_cluster.example.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.example.certificate_authority[0].data
}

output "identity" {
  value = aws_eks_cluster.example.identity
}

output "cluster_name" {
  value = aws_eks_cluster.example.id
}

output "cluster_security_group_id" {
  value = aws_eks_cluster.example.vpc_config[0].cluster_security_group_id
}