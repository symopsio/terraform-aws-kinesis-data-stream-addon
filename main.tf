data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  escaped_resource_arns     = [for arn in var.stream_arns : "\"${arn}\""]
  data_stream_resource_arns = join(",", local.escaped_resource_arns)
}

resource "aws_iam_policy" "this" {
  name = "SymKinesisDataStream${title(var.environment)}"
  path = "/sym/"

  description = "AWS IAM Policy granting permissions to publish to Kinesis Data Stream"
  policy      = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "kinesis:PutRecord",
        "kinesis:PutRecords"
      ],
      "Resource": [ ${local.data_stream_resource_arns} ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "kinesis:ListStreams"
      ],
      "Resource": "*"
    }
  ]
}
EOT
}

resource "aws_iam_role_policy_attachment" "attach_secrets_manager_access" {
  # If an IAM Role is specified, then attach the policy to that IAM Role.
  count = var.iam_role_name != "" ? 1 : 0

  policy_arn = aws_iam_policy.this.arn
  role       = var.iam_role_name
}
