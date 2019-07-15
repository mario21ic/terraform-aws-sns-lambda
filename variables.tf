variable "region" {
  description = "aws region"
  #default     = "eu-west-1"
}

variable "env" {
  description = "Environment name"
}

variable "name" {
  description = "Name"
}

variable "file_name" {
  description = "File name"
}

variable "engine" {
  description = "engine lambda"
}

variable "slack_url" {
  description = "Slack url"
}

variable "slack_channel" {
  description = "Slack channel"
}

variable "slack_user" {
  description = "Slack user"
}
