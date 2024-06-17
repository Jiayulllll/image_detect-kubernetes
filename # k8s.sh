#doker
docker build -t flask-app .
#run a container
docker run -d -p 5000:5000 --name my-flask-app flask-app



ssh -i ~/.ssh/ssh-key-2022-04-23.key ubuntu@

# k8s
sudo apt update
sudo apt -y full-upgrade

# Kubernete add to distribution
#Install package
 sudo apt -y install curl apt-transport-https 
#install key to verify the source of kuernet
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
#dm create kubernete ctl manage the kubernete
sudo apt  -y install vim git curl wget kubelet kubeadm kubectl
#mark package cannot install upgrade or remove
sudo apt-mark hold kubelet kubeadm kubectl
#check version
kubectl version --client && kubeadm version
#disable swap
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a

# Enable kernel modules
sudo modprobe overlay
sudo modprobe br_netfilter

# Add some settings to sysctl
sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# Reload sysctl
sudo sysctl --system
#install kubernetes sucessful 


#Install Container runtime
# Add repo and Install packages
sudo apt update
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
#install the docker
sudo apt install -y containerd.io docker-ce docker-ce-cli

# Create required directories
sudo mkdir -p /etc/systemd/system/docker.service.d

# Create daemon json config file
sudo tee /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

# Start and enable Services
sudo systemctl daemon-reload 
sudo systemctl restart docker
sudo systemctl enable docker
#Enable kubelet service
sudo systemctl enable kubelet

#Bootstrap without shared endpoint
sudo kubeadm init --pod-network-cidr=192.168.0.0/16

#reset network
sudo kubeadm reset
sudo rm -rf /etc/kubernetes
sudo rm -rf /etc//cni/net.d
sudo rm -rf /var/lib/kubelet
sudo rm -rd /var/lib/etcd
sudo rm -rf $HOME/ .kube

#join the nood
#calico
kubeadm join 10.0.0.125:6443 --token ******************* --discovery-token-ca-cert-hash ***********

kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml 
kubectl create -f https://docs.projectcalico.org/manifests/custom-resources.yaml
sudo cat /etc/systemd/system/kubelet.service

#weave:
sudo kubeadm init --pod-network-cidr=10.32.0.0/12
kubeadm join 10.0.0.158:6443 --token r0mszn.553v8qefxcb99r43 --discovery-token-ca-cert-hash ***************
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
kubectl get pods --all-namespaces
watch kubectl get pods --all-namespaces
#add note to cluster
kubectl get nodes
kubeadm token create --print-join-command


#firewall
sudo apt install firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --state
sudo firewall-cmd --permanent --zone=public --add-port=6443/tcp
sudo firewall-cmd --reload



#create yaml
nano myweb-deployment.yml
kubectl apply -f myweb-deployment.yml 
nano myweb-service.yml
kubectl apply -f myweb-service.yml
kubectl get nodes,pods,services,deployments -owide

curl localhost:30000


## firewall change for last step
sudo iptables-save > ~/iptables-rules
#modify rules remove drop and reject lines
grep -v "DROP" iptables-rules > tmpfile && mv tmpfile iptables-rules-mod
grep -v "REJECT" iptables-rules > tmpfile && mv tmpfile iptables-rules-mod
#apply the modification
sudo iptables-restore < ~/iptables-rules-mod
#check
sudo iptables -L
#save the change
sudo netfilter-persistent save
sudo systemctl restart iptables


# kill listening
sudo apt install net-tools
netstat -tlpen | grep 30000
sudo lsof -t -i:





#
kubectl get pods
kubectl logs

kubectl version --client && kubeadm version
docker --version
kubectl get nodes -o wide
nano myweb-deployment.yml
nano myweb-service.yml
kubectl get pods