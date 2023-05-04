output "policy_arn" {
  description = "The ARN of the generated AWS IAM Policy that grants permissions to publish to the given Kinesis Data Streams."
  value       = aws_iam_policy.this.arn
}
