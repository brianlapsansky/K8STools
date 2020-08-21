#!/bin/bash

# Join worker nodes to the Kubernetes cluster
echo "[TASK 1] Join node to Kubernetes Cluster"
#yum install -q -y sshpass >/dev/null 2>&1
wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm
yum --enablerepo=epel -y install sshpass
sshpass -p "kubeadmin" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no kmaster.example.com:/joincluster.sh /joincluster.sh 2>/dev/null
bash /joincluster.sh >/dev/null 2>&1
