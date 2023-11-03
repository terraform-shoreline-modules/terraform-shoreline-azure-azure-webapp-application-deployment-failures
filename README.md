
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Azure WebApp Application Deployment Failures
---

This incident type refers to the failure of deployment for web applications hosted on the Azure WebApp platform. The applications fail to update due to various reasons such as incorrect configuration of deployment sources like Azure DevOps, GitHub, Bitbucket, and errors in deployment logs. The resolution of this incident is to check the logs for errors, verify the application settings, and connection strings.

### Parameters
```shell
export WEB_APP_NAME="PLACEHOLDER"

export RESOURCE_GROUP_NAME="PLACEHOLDER"

export DATABASE_CONNECTION_STRING="PLACEHOLDER"

export API_ENDPOINT="PLACEHOLDER"
```

## Debug

### List all the web apps deployed on Azure
```shell
az webapp list --query '[].name'
```

### View the deployment details for a specific web app
```shell
az webapp deployment source show --name ${WEB_APP_NAME} --resource-group ${RESOURCE_GROUP_NAME}
```

### Check the deployment logs for a specific web app
```shell
az webapp log tail --name ${WEB_APP_NAME} --resource-group ${RESOURCE_GROUP_NAME}
```

### Verify the application settings for a specific web app
```shell
az webapp config appsettings list --name ${WEB_APP_NAME} --resource-group ${RESOURCE_GROUP_NAME}
```

### Check the connection string for the specific web app
```shell
az webapp config connection-string list --name ${WEB_APP_NAME} --resource-group ${RESOURCE_GROUP_NAME}
```

## Repair

### Verify application settings: Check the application settings to ensure they are correctly configured for the WebApp environment. Verify the database connection strings, API endpoints, and other configuration settings.
```shell


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
```