

resource "aws_eks_addon" "eks_addons" {
  cluster_name = var.cluster_name
  addon_name   = var.addon_name
}