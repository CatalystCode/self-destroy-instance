# Self destroy instance 
Self destroy linux instance in Azure Virtual Machine Scale Sets

## Prerequisites

To use this script, first you need to create an Azure Service Principal through [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli?toc=%2fazure%2fazure-resource-manager%2ftoc.json) or [Azure portal](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal).

## How to use

Define the following environment variables

#### Using Docker

Inside the Dockerfile or use the -e option
```
TENANT_ID = {Directory Id}
CLIENT_ID = {Serivce Principal Id}
CLIENT_SECRET = {Service Principal Secret}
SUBSCRIPTION_ID = {Subscripton Id}
RESOURCE_GROUP = {Resource group name} // Until it will be included in the VM Instance metadata
```
#### Using as a simple script inside the os
```
export TENANT_ID = {Directory Id}
export CLIENT_ID = {Serivce Principal Id}
export CLIENT_SECRET = {Service Principal Secret}
export SUBSCRIPTION_ID = {Subscripton Id}
export RESOURCE_GROUP = {Resource group name} // Until it will be included in the VM Instance metadata
```
