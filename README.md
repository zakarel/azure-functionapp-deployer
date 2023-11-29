# Azure FunctionApp deployer (Using existing resources)

<img src="https://img.shields.io/badge/Azure%20CLI%20-v2.19.1-blue?style=flat-square">   <img src="https://img.shields.io/badge/VSCode%20-v1.53.2-purple?style=flat-square">


Deploy Azure funtionapp in 2 major steps:
1. Creating the function app with the following resources:
 - storage account
 - app service plan
2. Deploying existing local project to the same functionapp created

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

- Unix based working env
- Azure CLI
- existing Azure resources:
 - Azure's subscription

### Installing

1. Cloning the project to you local workstation:

```
git clone git@github.com:zakarel/azure-functionapp-deployer.git
```
2. Add execute permission to the deployment script:

```
chmod +x deploy.sh
```

## Configuration

1. Change the following parameters inside the deploy.sh shell script file:
```
    "siteName": "(default: <Input of script>)"
    "storageAccountName": "(default: st$funcName)"
    "location": "(default: resource group location)"
    "functionWorkerRuntime": "(default: node)" "Accepted strings: node, dotnet, java"
    "environment": "(defualt: dev)" "Accepted strings: dev, prod"
```

## Deployment

```
./deploy.sh
```

## Authors

* **Tzahi Ariel** - *Initial work* - [zakarel](https://github.com/zakarel)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
