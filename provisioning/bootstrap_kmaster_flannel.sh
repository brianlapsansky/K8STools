
#!/bin/bash

# Initialize Kubernetes
echo "[TASK 1] Initialize Kubernetes Cluster"
kubeadm init --pod-network-cidr=10.244.0.0/16 >> /root/kubeinit.log 2>/dev/null

# Copy Kube admin config
echo "[TASK 2] Copy kube admin config to brian user .kube directory"
mkdir /home/brian/.kube
cp /etc/kubernetes/admin.conf /home/brian/.kube/config
chown -R brian:brian /home/brian/.kube

# Deploy flannel network
echo "[TASK 3] Deploy flannel network"
su - brian -c "kubectl create -f /home/brian/kube-flannel.yaml"

# Generate Cluster join command
echo "[TASK 4] Generate and save cluster join command to /joincluster.sh"
kubeadm token create --print-join-command > /joincluster.sh
