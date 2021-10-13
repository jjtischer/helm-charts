#!/usr/bin/env bash
set -o xtrace

ROOT_DIR=$(pwd)
source ${ROOT_DIR}/scripts/environment.sh

KUBECONFIG=${ROOT_DIR}/${EKS_CLUSTER_NAME}-kubeconfig.yaml
MONITORING_NAMESPACE=monitoring

if [[ $1 = "repos" ]]; then
  helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
  helm repo add grafana https://grafana.github.io/helm-charts
  helm repo add fluent https://fluent.github.io/helm-charts
  helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
  helm repo add kiali https://kiali.org/helm-charts
  helm repo add kube-state-metrics https://kubernetes.github.io/kube-state-metrics
  helm repo add aspenmesh https://aspenmesh.github.io/helm-charts
  helm repo update
  exit 0
fi

if [[ $1 = "grafana-stack-install" ]]; then
  kubectl --kubeconfig ${KUBECONFIG} create namespace ${MONITORING_NAMESPACE}
  helm --kubeconfig ${KUBECONFIG} install grafana-stack aspenmesh/grafana-stack --namespace ${MONITORING_NAMESPACE}
  exit 0
fi


if [[ $1 = "kiali-stack-install" ]]; then
  kubectl --kubeconfig ${KUBECONFIG} create namespace ${MONITORING_NAMESPACE}
  helm --kubeconfig ${KUBECONFIG} install kiali-stack aspenmesh/kiali-stack --namespace ${MONITORING_NAMESPACE}
  exit 0
fi


echo "please specify action ./helm.sh repos/grafana-stack-install/kiali-stack-install"
exit 1