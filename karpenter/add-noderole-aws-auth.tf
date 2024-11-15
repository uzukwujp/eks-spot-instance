
locals {
  existing_roles    = try(yamldecode(data.kubernetes_config_map.aws_auth_existing.data["mapRoles"]), [])
  existing_users    = try(yamldecode(data.kubernetes_config_map.aws_auth_existing.data["mapUsers"]), [])
  existing_accounts = try(yamldecode(data.kubernetes_config_map.aws_auth_existing.data["mapAccounts"]), [])
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = jsonencode(
      concat(
        local.existing_roles,
        [
          {
            "rolearn"  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${aws_iam_role.karpenter_node_role.name}",
            "username" = "system:node:{{EC2PrivateDNSName}}",
            "groups"   = ["system:bootstrappers", "system:nodes"]
          }
        ]
      )
    )

    mapUsers = jsonencode(local.existing_users)

    mapAccounts = jsonencode(local.existing_accounts)
  }
}
