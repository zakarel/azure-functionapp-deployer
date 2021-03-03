#!/bin/bash

# Variables: #
templateFile="azuredeploy.json"
subscription=""
RG=""
ENV=""

# Banner #
cat banner.txt

# Validation #
# Checking for a compressed functionapp project
if [ `find . -name "*.[zip|9z|tar|gz|tgz]*" | wc -l` != 1 ]
then
	echo "Can't find compressed functionapp project in this folder"
	echo "Please add the archive file to this script same folder and re-run"
	echo "Make sure ONLY ONE compressed file is inside this folder"
	exit 2
fi

funcProject=`find . -name "*.[zip|9z|tar|gz|tgz]*"`

# Signin Option1 - Logging (One option should be marked) #
az login
az account set -s $subscription

# Signin Option2 - Logging (One option should be marked) #
#read -p "Azure Username: " AZ_USER && echo
#read -sp "Azure Password: " AZ_PASS && echo && az login -u $AZ_USER -p $AZ_PASS

# Catching Input #
echo "This script will create a new Function app on $subscription in $RG resource group"
echo
read -p "Enter new functionapp name (MUST BE - Globally unique, [a-z,0-9,-]): " funcName
if [ -z $funcName ]
 then
	 echo "invalid name entered!"
	 sleep 2
	 exit 1
fi

az deployment group create \
  --name tmpl-fifa-functions-nonprod \
  --resource-group $RG \
  --template-file $templateFile \
  --parameters appName="$funcName" \
  --rollback-on-error \
  --confirm-with-what-if

# Deleting Old Template
if [ $? -eq 0 ]
then
	az deployment group delete -g rg-serverless-nonprod-eastus -n tmpl-fifa-functions-nonprod
fi


# Deploying FunctionApp #
echo "FunctionApp Publish Phase..."
az functionapp deployment source config-zip -g $RG -n \
$funcName --src $funcProject

