#!/bin/sh
sudo snap install microk8s --classic
microk8s enable dns
microk8s enable dashboard
microk8s config > ~/.kube/config

microk8s kubectl create namespace argocd
microk8s kubectl apply -n argocd -f bootstrap/argocd-install.yaml 
helm install root-app root-app
# expose argo through proxy
# kubectl port-forward podname 8080:8080 -n argocd

# Initial argocd password:
# kubectl get secrets/argocd-initial-admin-secret -n argocd --template={{.data.password}} | base64 -d

kubectl create ns external-dns
kubectl create ns cert-manager
kubectl apply -n external-dns -f local-files/dns.yaml
kubectl apply -n cert-manager -f local-files/dns.yaml