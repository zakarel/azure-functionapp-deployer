# Azure FunctionApp deployer (Using existing resources)

Deploy Azure funtionapp in 2 major steps:
1. Creating the function app with the connection to 3 existing resources:
 - storage account
 - app service plan
 - application insights
2. Deploying existing local project to the functionapp created

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

- unix based working env
- text editor tool
- Azure CLI
- existing Azure resources:
 - subscription
 - storage account
 - application insight
 - app service plan

### Installing

1. Cloning the project to you local workstation:

```
git clone git@github.com:zakarel/Azure-functionapp-deployer.git
```
2. Add execute permission to the deployment script:

```
chmod +x deploy.sh
```

## Configuration

1. Change the following variables (placeholder) inside the ARM Template json file azuredeploy.json
```
    "hostingPlanName": "<existing app service plan name>"
    "location": "<region>"
    "applicationInsightsName": "<existing application insights name>"
    "storageAccountName": "<existing storage account name>"
    "functionWorkerRuntime": "<runtime (ex. node)>"
```
2. Change the following variables (placeholder) inside the deployment script file deploy.sh
```
subscription="<subscription name which the az login will connect to>"
RG="<ResourceGroup to put the new functionapp resource>"
ENV="<optional - dev/prod - added to the func name>"
```

## Deployment

```
./deploy.sh
```

## Authors

* **Tzahi Ariel** - *Initial work* - [zakarel](https://github.com/zakarel)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
