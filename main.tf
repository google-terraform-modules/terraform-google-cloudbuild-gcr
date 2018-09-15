# Use this data source to get project details. For more information see API.
# https://www.terraform.io/docs/providers/google/d/google_project.html
data "google_project" "project" {}

# Create Git repository
# https://www.terraform.io/docs/providers/google/r/sourcerepo_repository.html
resource "google_sourcerepo_repository" "new_git_repository" {
  name = "${var.repository}"
}

# Create CloudBuild Trigger
# https://www.terraform.io/docs/providers/google/r/cloudbuild_trigger.html
resource "google_cloudbuild_trigger" "new_git_build_trigger" {
  count       = "${length(var.triggers)}"
  description = "Trigger Git repository ${var.repository} / ${lookup(var.triggers[count.index], "branch", "master")}"

  trigger_template {
    project     = "${data.google_project.project.project_id}"
    branch_name = "${lookup(var.triggers[count.index], "branch", "master")}"
    repo_name   = "${var.repository}"
  }

  build {
    images = ["gcr.io/$PROJECT_ID/$REPO_NAME:${lookup(var.triggers[count.index], "tag_type", "$BRANCH_NAME")}"]

    step {
      name = "gcr.io/cloud-builders/docker"
      args = "build -t gcr.io/$PROJECT_ID/$REPO_NAME:${lookup(var.triggers[count.index], "tag_type", "$BRANCH_NAME")} -f Dockerfile ."
    }
  }

  # Google Git repository has been created.
  depends_on = [
    "google_sourcerepo_repository.new_git_repository",
  ]
}
