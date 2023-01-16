sudo snap install microk8s --classic
microk8s enable dns
microk8s enable dashboard
microk8s config > ~/.kube/config

kubectl create namespace argocd; kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# kubectl get pods -n argocd | grep argocd-server #Pod name is pass, user: admin # it's in argocd-initial-admin-secret secret
 kubectl get secrets/argocd-initial-admin-secret -n argocd --template={{.data.password}} | base64 -d