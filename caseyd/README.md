# Casey Dinsmore

Working directory for Casey Dinsmore


# Common Commands

## Helm

### Install / Reconfigure

  helm upgrade --cleanup-on-fail \
    --install jhub jupyterhub/jupyterhub \
    --namespace jhub \
    --create-namespace \
    --version=2.0.0 \
    --values config.yaml

## Kubectl

### Get Proxy Address
 kubectl -n jhub get service proxy-public

### Show all pod states
 kubectl get pods -A

### View details about a pod including deployment errors
 kubectl -n jhub describe pod <pod.name>

### Get the logs for a pod
 kubectl -n jhub get logs <pod.name>

### Get Persistent Volumes/Claims
 kubectl -n jhub get pv
 kubectl -n jhub get pvc
