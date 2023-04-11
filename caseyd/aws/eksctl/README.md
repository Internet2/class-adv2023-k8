# AWS EKS cluster config with eksctl

## Resources

https://www.arhea.net/posts/2020-06-18-jupyterhub-amazon-eks


## Issues

* With 4 availability zones in us-west-2, eksctl will randomly pick three and
so sometimes the deployment will fail.

Adding the AvailibilityZones: stanza to cluster.yaml resolves the issue as outlined here:

https://github.com/weaveworks/eksctl/blob/main/examples/05-advanced-nodegroups.yaml

 availabilityZones: ["us-west-2a", "us-west-2b", "us-west-2d"]

* Hubs end up stuck in the Pending state

 running PreBind plugin "VolumeBinding": binding volumes: timed out waiting for the condition

Resolution here does not seem to work

https://discourse.jupyter.org/t/hub-pod-stuck-on-pending-timed-out-binding-volumes/17176
