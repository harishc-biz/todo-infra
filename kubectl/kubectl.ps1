#to create a new namespace
kubectl create ns todo-app

#to create a new secret
kubectl create secret docker-registry acr-auth \
  --docker-server=<acr-name>.azurecr.io \
  --docker-username=<service-principal-id> \
  --docker-password=<service-principal-password>

#ArgoCD installation
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml