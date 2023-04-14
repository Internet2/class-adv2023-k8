import sys
import os
from azure.mgmt.compute import ComputeManagementClient
from azure.identity import ClientSecretCredential
from dotenv import load_dotenv # Add dotenv module to read credentials

# Load credentials from .env file
load_dotenv()
subscription_id = os.getenv("SUBSCRIPTION_ID")
tenant_id = os.getenv("TENANT_ID")
client_id = os.getenv("CLIENT_ID")
client_secret = os.getenv("CLIENT_SECRET")

# Checking if the correct number of command-line arguments are provided
if len(sys.argv) != 4:
    print("Usage: python3 operator.py <action> <resource_group> <vm_name>")
    sys.exit(1)

def startdeallocate_vm(action, subscription_id, tenant_id, client_id, client_secret, resource_group_name, vm_name):
    # Create credentials object
    credentials = ClientSecretCredential(
        tenant_id=tenant_id,
        client_id=client_id,
        client_secret=client_secret
    )

    # Create ComputeManagementClient - it includes begin_run_command
    compute_client = ComputeManagementClient(credentials, subscription_id)
    if action == "deallocate":
        compute_client.virtual_machines.begin_deallocate(resource_group_name, vm_name)
        return f"Virtual machine {vm_name} in resource group {resource_group_name} has been deallocated."
    elif action == "start":
        # Start the virtual machine
        compute_client.virtual_machines.begin_start(resource_group_name, vm_name)
        return f"Virtual machine {vm_name} in resource group {resource_group_name} has been started."
    else:
        # Handle unknown actions
        return f"Unknown action. Virtual machine {vm_name} in resource group {resource_group_name} was not altered."

# Example usage
resource_group_name = sys.argv[2]
vm_name = sys.argv[3]

result = startdeallocate_vm(sys.argv[1], subscription_id, tenant_id, client_id, client_secret, resource_group_name, vm_name)
print(result)
