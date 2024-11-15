

resource "aws_security_group" "karpenter_nodes" {
  name        = "eks-nodes-${var.cluster_name}"
  description = "Security group for worker nodes in cluster ${var.cluster_name}"
  vpc_id      = var.vpc_id

  tags = {
    Name                                        = "karpenter-nodes-${var.cluster_name}"
    "karpenter.sh/discovery"                    = var.cluster_name
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

# Allow all inbound traffic from the worker nodes to themselves
resource "aws_security_group_rule" "nodes_internal" {
  description              = "Allow nodes to communicate with each other on all ports"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.karpenter_nodes.id
  source_security_group_id = aws_security_group.karpenter_nodes.id
  type                     = "ingress"
}

# Allow all inbound traffic from the worker nodes to the control plane
resource "aws_security_group_rule" "nodes_to_control_plane" {
  description              = "Allow all traffic from worker nodes to control plane"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = var.cluster_security_group_id
  source_security_group_id = aws_security_group.karpenter_nodes.id
  type                     = "ingress"
}

# Allow all inbound traffic from the control plane to the worker nodes
resource "aws_security_group_rule" "control_plane_to_nodes" {
  description              = "Allow all traffic from control plane to worker nodes"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.karpenter_nodes.id
  source_security_group_id = var.cluster_security_group_id
  type                     = "ingress"
}

# Allow worker nodes outbound internet access (remains unchanged)
resource "aws_security_group_rule" "nodes_outbound" {
  description     = "Allow nodes outbound internet access"
  from_port       = 0
  protocol        = "-1"
  security_group_id = aws_security_group.karpenter_nodes.id
  to_port         = 0
  type            = "egress"
  cidr_blocks     = ["0.0.0.0/0"]
}
