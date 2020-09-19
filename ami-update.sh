#!/bin/bash

# FROM: Ubuntu 18.04 latest us-west-2 AMI

sudo -i

apt-get update
apt-get -y upgrade

apt-get -y install docker.io
systemctl enable --now docker
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

apt-get install kubeadm=1.19.2-00 kubectl=1.19.2-00 kubelet=1.19.2-00 kubernetes-cni=0.8.7-00 -y -f
apt-mark hold kubeadm kubelet kubectl kubernetes-cni
echo v1.19.2 > /etc/kubernetes_community_ami_version

apt-get -y install python-pip
pip install https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz
apt-get -y install ec2-instance-connect 
pip install awscli

history -c