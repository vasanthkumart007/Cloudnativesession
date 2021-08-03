#!/bin/bash
# change directory to our k8s configuration files
cd ~/environment/stpEksLabRepo/eks-lab-app/
# create the development namespace
kubectl create -f namespace.yaml
# create a new context, we will name it “containers-lab”
kubectl config set-context containers-lab --namespace=containers-lab --cluster=kubernetes --user=aws
# Switch to context “containers-lab”:
kubectl config use-context containers-lab