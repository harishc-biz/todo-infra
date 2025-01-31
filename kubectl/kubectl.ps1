#to create a new namespace
kubectl create ns todo-app

#to create a new secret
kubectl create secret docker-registry acr-auth \
  --docker-server=<acr-name>.azurecr.io \
  --docker-username=<service-principal-id> \
  --docker-password=<service-principal-password>