

#!/bin/bash



# Get the resource group and WebApp name

resource_group=${RESOURCE_GROUP_NAME}

webapp_name=${WEB_APP_NAME}



# Values to be added as key value pair

DATABASE_CONNECTION_STRING=${DATABASE_CONNECTION_STRING}

API_ENDPOINT=${API_ENDPOINT}



# Verify the application settings

az webapp config appsettings list --resource-group $resource_group --name $webapp_name



# Update the database connection string

az webapp config appsettings set --resource-group $resource_group --name $webapp_name --settings $DATABASE_CONNECTION_STRING



# Update the API endpoint

az webapp config appsettings set --resource-group $resource_group --name $webapp_name --settings $API_ENDPOINT



# Verify the updated settings

az webapp config appsettings list --resource-group $resource_group --name $webapp_name



# Retry the deployment

az webapp deployment source sync -g $resource_group -n $webapp_name