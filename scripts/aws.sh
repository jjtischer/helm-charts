#!/usr/bin/env bash

ROOT_DIR=$(pwd)
source ${ROOT_DIR}/scripts/environment.sh
set -o xtrace

if [[ $1 = "login" ]]; then
	aws configure --profile ${AWS_PROFILE}
  exit 0
fi

export KUBECONFIG=${ROOT_DIR}/${EKS_CLUSTER_NAME}-kubeconfig.yaml

if [[ $1 = "create" ]]; then
  echo "eksctl create cluster --name ${EKS_CLUSTER_NAME} --tags \"owner=${EKS_TAG_OWNER},email=${EKS_TAG_EMAIL},demo=aspenmesh-istio-demo\" --region ${EKS_CLUSTER_REGION} --version \"${EKS_K8S_VERSION}\" --node-type ${EKS_NODE_TYPE} --nodes ${EKS_CLUSTER_NODES_MIN} --nodes-min ${EKS_CLUSTER_NODES_MIN} --nodes-max ${EKS_CLUSTER_NODES_MAX} --ssh-access --instance-prefix aspenmesh --asg-access --external-dns-access --vpc-cidr ${EKS_CLUSTER_VPC_CIDR} --profile ${AWS_PROFILE} --kubeconfig ${KUBECONFIG}"

	eksctl create cluster \
		--name ${EKS_CLUSTER_NAME} \
		--tags "owner=${EKS_TAG_OWNER},email=${EKS_TAG_EMAIL},demo=aspenmesh-istio-demo" \
		--region ${EKS_CLUSTER_REGION} \
		--version "${EKS_K8S_VERSION}" \
		--node-type ${EKS_NODE_TYPE} \
		--nodes ${EKS_CLUSTER_NODES_MIN} \
		--nodes-min ${EKS_CLUSTER_NODES_MIN} \
		--nodes-max ${EKS_CLUSTER_NODES_MAX} \
		--ssh-access \
		--instance-prefix aspenmesh \
		--asg-access \
		--external-dns-access \
		--vpc-cidr ${EKS_CLUSTER_VPC_CIDR} \
		--profile ${AWS_PROFILE} \
		--kubeconfig ${KUBECONFIG}
  exit 0
fi

if [[ $1 = "delete" ]]; then
  echo "eksctl delete cluster --name ${EKS_CLUSTER_NAME} --region ${EKS_CLUSTER_REGION} --profile ${AWS_PROFILE}"
	eksctl delete cluster \
		--name ${EKS_CLUSTER_NAME} \
		--region ${EKS_CLUSTER_REGION} \
    --profile ${AWS_PROFILE}
  exit 0
fi

if [[ $1 = "info" ]]; then
  echo "kubectl get cluster-info"
	kubectl cluster-info
  echo "kubectl get all -A"
	kubectl get all -A -o wide
  exit 0
fi

if [[ $1 = "external-services" ]]; then
  echo "kubectl get svc -A -o wide | grep LoadBalancer"
  kubectl get svc -A -o wide | grep LoadBalancer
  exit 0
fi

echo "please specify action ./aws.sh login/create/delete/info/external-services"
exit 1
