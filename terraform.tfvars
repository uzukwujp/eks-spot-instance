
addons = [{
  addon_name    = "eks-pod-identity-agent"
  addon_version = "v1.3.2-eksbuild.2"
  },

  {
    addon_name    = "aws-ebs-csi-driver"
    addon_version = "v1.36.0-eksbuild.1"
  }
]
cidr_block                 = "10.0.0.0/16"
instance_tenancy           = "default"
enable_dns_hostnames       = "true"
tag                        = "testing"
region                     = "us-east-1"
cluster_name               = "poc-cluster"
cluster_role_name          = "poc-cluster-IAM-role"
az_count                   = 2
node_group_name            = "poc-worker-nodes"
instance_types             = ["t3.medium"]
capacity_type              = "ON_DEMAND"
desired_size               = 2
max_size                   = 4
max_unavailable            = 1
min_size                   = 1
worker_node_iam_role_name  = "poc-worker-node-IAM-role"
karpenter_version          = "1.0.0"
chart_version              = "7.7.1"
custom_values              = "argocd_values.yaml"
cluster_version            = "1.31"
repository_names   = [ 
  {
  "repo_name"      = "knowledgecity"
  } 
]


