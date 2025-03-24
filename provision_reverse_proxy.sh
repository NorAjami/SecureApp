#!/bin/bash

# Resource group and VM name
resource_group=SecureAppRG
vm_name=ReverseProxyVM
vm_port=80

# Skapa VM med Ubuntu och cloud-init
az vm create \
  --resource-group $resource_group \
  --name $vm_name \
  --image Ubuntu2204 \
  --size Standard_B1s \
  --admin-username azureuser \
  --generate-ssh-keys \
  --custom-data @cloud-init_nginx.yaml

# Öppna port 80 (HTTP) för webtrafik
az vm open-port \
  --port $vm_port \
  --resource-group $resource_group \
  --name $vm_name
