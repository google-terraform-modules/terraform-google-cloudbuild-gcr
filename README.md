# Google Repository Trigger(s) (GCR)

Compatible provider `1.17.1`


## Example

```hcl
module "trigger-gcr" {
  source     = "google-terraform-modules/cloudbuild-gcr/google"
  repository = "cloudfunction-graphql-list-object"

  triggers = [
    {
      branch = "master"
    },
    {
      branch = "dev"
      tag_type = "$SHORT_SHA"
    },
  ]
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| repository | Name of mirror repository on GCP | string | - | yes |
| triggers | Options of trigger | list | `<list>` | no |