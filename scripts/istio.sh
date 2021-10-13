#!/usr/bin/env bash

ROOT_DIR=$(pwd)
source ${ROOT_DIR}/scripts/environment.sh
set -o xtrace

KUBECONFIG=${ROOT_DIR}/${EKS_CLUSTER_NAME}-kubeconfig.yaml
ISTIO_OPERATOR_DIR=${ROOT_DIR}/scripts/istio-operator

if [[ $1 = "install-operator" ]]; then
  istioctl --kubeconfig ${KUBECONFIG} operator init
  exit 0
fi

if [[ $1 = "install-grafana-stack" ]]; then
  kubectl --kubeconfig ${KUBECONFIG} apply -f ${ISTIO_OPERATOR_DIR}/grafana-stack.yaml
  exit 0
fi

if [[ $1 = "install-kiali-stack" ]]; then
  kubectl --kubeconfig ${KUBECONFIG} apply -f ${ISTIO_OPERATOR_DIR}/loki-stack.yaml
  exit 0
fi

if [[ $1 = "istioctl" ]]; then
  curl -sL https://istio.io/downloadIstioctl | ISTIO_VERSION=${ISTIO_VERSION} sh - && \
  sudo cp ~/.istioctl/bin/istioctl /usr/local/bin
  exit 0
fi

echo "please specify action ./istio.sh install-operator/install-grafana-stack/install-kiali-stack/istioctl"
exit 1