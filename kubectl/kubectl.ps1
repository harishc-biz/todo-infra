#to create a new namespace
kubectl create ns todo-app

#to create a new secret
kubectl create secret docker-registry acr-auth \
  --docker-server=acrtododev.azurecr.io \
  --docker-username=acrtododev \
  --docker-password=iDOhN+ECrbUDg40w9F3LlzAVZefM6fMtgABtdlA3cH+ACRAiXTvX -n todo-app

#ArgoCD installation
kubectl create namespace argocd
kubectl apply -n argocd -f kubectl/ArgoCD/install.yml