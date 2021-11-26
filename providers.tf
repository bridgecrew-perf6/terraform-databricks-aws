provider "aws" {
  region = var.aws_baseline_account["region"]
}

// initialize provider in "MWS" mode to provision new workspace
provider "databricks" {
  alias    = "mws"
  host     = "https://accounts.cloud.databricks.com"
  username = var.databricks_account_username
  password = var.databricks_account_password
}

provider "databricks" {
  alias    = "created_workspace"
  host     = module.databricks_provisioning.databricks_host
  username = var.databricks_account_username
  password = var.databricks_account_password
}

// provider with user's token auth, necessary because the service ppal
// doesn't can't create clusters
provider "databricks" {
  alias = "create_clusters"
  host  = module.databricks_provisioning.databricks_host
  token = module.databricks_provisioning.create_cluster_token
}

// provider with service ppal auth
provider "databricks" {
  alias = "service_ppal"
  host  = module.databricks_provisioning.databricks_host
  token = module.databricks_provisioning.service_ppal_token
}

