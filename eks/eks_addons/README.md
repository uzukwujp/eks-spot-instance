
# Retrieve Valid EKS Addon Version

You can use the aws cli command below to retrieve a valid version of an EKS addon:

```
aws eks describe-addon-versions \
    --kubernetes-version=<kubernetes version> \
    --addon-name=<addon name> \
    --query='addons[].addonVersions[].addonVersion'
```