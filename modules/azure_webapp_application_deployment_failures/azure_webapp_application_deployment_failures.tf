resource "shoreline_notebook" "azure_webapp_application_deployment_failures" {
  name       = "azure_webapp_application_deployment_failures"
  data       = file("${path.module}/data/azure_webapp_application_deployment_failures.json")
  depends_on = [shoreline_action.invoke_webapp_config_update]
}

resource "shoreline_file" "webapp_config_update" {
  name             = "webapp_config_update"
  input_file       = "${path.module}/data/webapp_config_update.sh"
  md5              = filemd5("${path.module}/data/webapp_config_update.sh")
  description      = "Verify application settings: Check the application settings to ensure they are correctly configured for the WebApp environment. Verify the database connection strings, API endpoints, and other configuration settings."
  destination_path = "/tmp/webapp_config_update.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_webapp_config_update" {
  name        = "invoke_webapp_config_update"
  description = "Verify application settings: Check the application settings to ensure they are correctly configured for the WebApp environment. Verify the database connection strings, API endpoints, and other configuration settings."
  command     = "`chmod +x /tmp/webapp_config_update.sh && /tmp/webapp_config_update.sh`"
  params      = ["API_ENDPOINT","WEB_APP_NAME","RESOURCE_GROUP_NAME","DATABASE_CONNECTION_STRING"]
  file_deps   = ["webapp_config_update"]
  enabled     = true
  depends_on  = [shoreline_file.webapp_config_update]
}

