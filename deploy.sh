#!/bin/bash

# Variables: #
templateFile="azuredeploy.json"
subscription=""
RG=""
ENV=""

## Required for Signin Option2
AZ_USER=""
AZ_PASS=""

# Banner #
cat banner.txt

# Validation #
# Checking for a compressed functionapp project
if [ `find . -type f | grep '.zip' | wc -l` != 1 ]
then
	echo "Can't find compressed functionapp project in this folder or there is more than 1 in this folder"
	echo "Please add the zipped file to this script's folder and re-run"
	echo "Make sure only ONE compressed file is inside this folder"
	exit 2
fi

funcProject=`find . -type f | grep '.zip'`

# Signin Option1 - Logging (One option should be marked) #
echo "This script will authenticate with AAD over the web browser now"
sleep 1
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

# Drop all -,_ from storage account name #
stName=`echo "st${funcName//[-,.,_]}"`
funcName="$funcName-$ENV"
echo
sleep 1

az deployment group create \
  --name tmpl-functions-$ENV \
  --resource-group $RG \
  --template-file $templateFile \
  --parameters siteName=$funcName storageAccountName=$stName environment=$ENV \
  --rollback-on-error \
  --confirm-with-what-if


# Deleting Old Template
if [ $? -eq 0 ]
then
	az deployment group delete -g $RG -n tmpl-functions-$ENV
fi

# Deploying FunctionApp #
echo "FunctionApp Publish Phase..."
az functionapp deployment source config-zip -g $RG -n \
$funcName --src $funcProject

