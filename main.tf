locals {
  commonTags = {
    InfraId = var.clusterName
    "k8s.io/cluster-autoscaler/enabled" = "true"
    "k8s.io/cluster-autoscaler/${var.clusterName}" = "owned"
  }
}

# Using these data sources allows the configuration to be
# generic for any region.
data "aws_region" "current" {}
data "aws_availability_zones" "available" {}
