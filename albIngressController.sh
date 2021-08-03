#!/bin/bash
# Create an IAM OIDC (Open ID Connect) provider
eksctl utils associate-iam-oidc-provider --region us-east-2 --cluster eks-lab-cluster --approve
# Download the IAM policy for the ALB Ingress Controller pod
curl -o iam-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.4/docs/examples/iam-policy.json
# Create an IAM policy called ALBIngressControllerIAMPolicy
aws iam create-policy --policy-name ALBIngressControllerIAMPolicy --policy-document file://iam-policy.json
# Create a Kubernetes service account named alb-ingress-controller in the kube-system namespace
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.4/docs/examples/rbac-role.yaml
sleep 5
# Create an IAM role for the ALB Ingress Controller and attach the role to the service account
eksctl create iamserviceaccount --region us-east-2 --name alb-ingress-controller --namespace kube-system --cluster eks-lab-cluster --attach-policy-arn arn:aws:iam::$ACCOUNT_NUMBER:policy/ALBIngressControllerIAMPolicy --override-existing-serviceaccounts --approve
# Deploy the ALB Ingress Controller
kubectl apply -f alb-ingress-controller.yaml