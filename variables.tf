variable "environment" {
  description = "The unique name of the environment in which you are deploying this AWS IAM Policy (e.g. staging, or prod)."
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to resources."
  type        = map(string)
  default     = {}
}

variable "stream_arns" {
  description = "List of Data Stream ARNs allowed to be published to by the Sym Runtime."
  type        = list(string)
  default     = []
}

variable "iam_role_name" {
  description = "If specified, the generated AWS IAM Policy will be attached to the AWS IAM Role identified by this value."
  type        = string
  default     = ""
}
