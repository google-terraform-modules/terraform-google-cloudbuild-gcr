variable "repository" {
  type        = "string"
  description = "Name of mirror repository on GCP"
}

# Parameters authorized:
# branch (default: master)
# tag_type (default: $BRANCH_NAME) => https://www.terraform.io/docs/providers/google/r/cloudbuild_trigger.html#build
variable "triggers" {
  type        = "list"
  default     = []
  description = "Options of trigger"
}
