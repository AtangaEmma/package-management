# Configure kubectl as a normal ubuntu user
# Exit as root user

sudo su - ubuntu

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# To verify, if kubectl is working or not, run the following command.

kubectl get pods -o wide -n kube-system

#You will notice from the previous command, that all the pods are running except one: ‘core-dns’. For resolving this we will install a # pod network addon like Calico or Weavenet ..etc. 
#Note: Install any one network addon don't install both. Install either weave net or calico.
#To install Weave network plugin/addon run the following command.

kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
