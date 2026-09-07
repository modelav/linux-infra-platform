resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  tags = {
    Name      = "github-actions-oidc"
    Project   = "linux-infra-platform"
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_role" "github_actions_deploy" {
  name = "linux-infra-github-actions-deploy"

  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role.json

  tags = {
    Name      = "linux-infra-github-actions-deploy"
    Project   = "linux-infra-platform"
    ManagedBy = "Terraform"
  }
}