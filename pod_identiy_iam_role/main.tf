
# IAM Role with custom assume role policy for Pod Identity
resource "aws_iam_role" "pod_identity_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
      }
    ]
  })
}

#creates a custom policy document using the json file passed in as input
resource "aws_iam_policy" "custom_policy" {
  name   = "${var.role_name}_custom_policy"
  policy = var.custom_policy_document
}

# attaches the custom policy to the IAM role
resource "aws_iam_role_policy_attachment" "custom_policy_attachment" {
  role       = aws_iam_role.pod_identity_role.name
  policy_arn = aws_iam_policy.custom_policy.arn
}


