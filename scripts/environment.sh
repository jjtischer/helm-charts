#!/usr/bin/env bash

# Check local requirements (binaries used during the installation process)
function check_local_requirements {
  deps=( eksctl kubectl helm )

  for dep in "${deps[@]}"
  do
    if ! command -v ${dep} &> /dev/null
    then
        echo "${dep} could not be found, please install this on your local system first"
        exit
    fi
  done
}

check_local_requirements

### AWS EKS SECTION ###

export EKS_K8S_VERSION=1.21
export EKS_NODE_TYPE=m5.2xlarge
export EKS_TAG_OWNER=bartvanbos
export EKS_TAG_EMAIL=b.vanbos@F5.com

export AWS_PROFILE=aws-eks-istio-demo

export EKS_CLUSTER_NAME=istio-aspendemo
export EKS_CLUSTER_REGION=eu-west-1
export EKS_CLUSTER_VPC_CIDR=10.10.0.0/16
export EKS_CLUSTER_NODES_MIN=5
export EKS_CLUSTER_NODES_MAX=6
