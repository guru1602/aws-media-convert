variable "aws_assume_role_arn" {
  type    = string
  default = ""
}

variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "namespace" {
  type        = string
  default     = ""
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "stage" {
  type        = string
  default     = ""
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
}

// bucket

variable "bucket_name" {
  type = string
}
