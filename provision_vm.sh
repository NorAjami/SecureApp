#!/bin/bash

# provision_vm.sh – skapar din VM i Azure och öppnar port 5000

resource_group=SecureAppRG
vm_name=SecureAppVM
vm_port=5000

# Skapa resursgrupp
az group create --location northeurope --name $resource_group

# Skapa VM och installera .NET med cloud-init
az vm create --name $vm_name --resource-group $resource_group \
             --image Ubuntu2204 --size Standard_B1s \
             --generate-ssh-keys --admin-username azureuser \
             --custom-data @cloud-init_dotnet.yaml

# Öppna port 5000 så vi kan nå webbsidan BYT NAMN
az vm open-port --port $vm_port --resource-group $resource_group --name $vm_name

# Öppna port 80 (så man kan gå in utan att skriva :5000 i webbläsaren) BYT NAMNN
az vm open-port --port 80 --resource-group $resource_group --name $vm_name
