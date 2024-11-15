 # Example usage

```
 module "pod_identity_iam_role" {
  source                = "./modules/iam_role"
  role_name             = "my-pod-identity-role"
  custom_policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:ListBucket", "s3:GetObject"]
        Resource = ["arn:aws:s3:::my-example-bucket", "arn:aws:s3:::my-example-bucket/*"]
      }
    ]
  })
}

```