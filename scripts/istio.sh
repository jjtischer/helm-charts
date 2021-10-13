#!/usr/bin/env bash
set -o xtrace

ROOT_DIR=$(pwd)
source ${ROOT_DIR}/scripts/environment.sh

KUBECONFIG=${ROOT_DIR}/${EKS_CLUSTER_NAME}-kubeconfig.yaml

if [[ $1 = "install" ]]; then
  istioctl --kubeconfig ${KUBECONFIG} operator init
  exit 0
fi

if [[ $1 = "istioctl" ]]; then
  curl -sL https://istio.io/downloadIstioctl | ISTIO_VERSION=${ISTIO_VERSION} sh - && \
  sudo cp ~/.istioctl/bin/istioctl /usr/local/bin
  exit 0
fi

echo "please specify action ./istio.sh install/istioctl"
exit 1