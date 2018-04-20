# stores the terraform state in S3
terraform {
  backend "s3" {
    bucket = "jaydp-terraform-states"
    key    = "block-cluster-k8s.jaydp.com"
    region = "ap-south-1"
  }
}
