#! /bin/bash
############################################
# This script will help bind the fqdn
# to the Jupyterhub static IP address.
# This usefull on Azure. You probably have
# similar process on other cloud provide
#
# Original script from here
# https://docs.microsoft.com/en-us/azure/aks/ingress-tls
# Synopsis:
# ./bind-jhub-fqdn2IP.sh <IP> <NAME>
# CC 2023-04-11 Jacob Fosso Tande
#########################################
# configure an FQDN for the ingress controller IP address
# Public IP address of your ingress controller
IPADDRESS=$1
NAME=$2
IP="$IPADDRESS"

# Name to associate with public IP address
DNSNAME="$NAME"

# Get the resource-id of the public ip
PUBLICIPID=$(az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$IP')].[id]" --output tsv)

# Update public ip address with DNS name
az network public-ip update --ids $PUBLICIPID --dns-name $DNSNAME

# Display the FQDN
FQDN=$(az network public-ip show --ids $PUBLICIPID --query "[dnsSettings.fqdn]" --output tsv)

echo "  "
echo "  " 
echo " Got FQDN "
echo "  "
echo " "
echo $FQDN
echo "  "
echo "  "
