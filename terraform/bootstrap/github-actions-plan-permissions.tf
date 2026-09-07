data "aws_iam_policy_document" "github_actions_plan" {
  statement {
    sid    = "TerraformState"
    effect = "Allow"

    actions = [
      "s3:ListBucket"
    ]

    resources = [
      aws_s3_bucket.terraform_state.arn
    ]
  }

  statement {
    sid    = "TerraformStateObjects"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "${aws_s3_bucket.terraform_state.arn}/*"
    ]
  }

  statement {
    sid    = "EC2Describe"
    effect = "Allow"

    actions = [
      "ec2:Describe*"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "github_actions_plan" {
  name = "linux-infra-github-actions-plan"
  role = aws_iam_role.github_actions_plan.id

  policy = data.aws_iam_policy_document.github_actions_plan.json
}