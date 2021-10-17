#!/usr/bin/env bash

ROOT_DIR=$(pwd)
source ${ROOT_DIR}/scripts/environment.sh
set -o xtrace

export KUBECONFIG=${ROOT_DIR}/${EKS_CLUSTER_NAME}-kubeconfig.yaml
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

if [[ $1 = "list" ]]; then
  helm repo update
  helm search repo aspenmesh
  exit 0
fi


if [[ $1 = "elastic-stack-install" ]]; then
  kubectl create namespace ${MONITORING_NAMESPACE}
  helm install elastic-stack aspenmesh/elastic-stack --namespace ${MONITORING_NAMESPACE}
  exit 0
fi

if [[ $1 = "elastic-stack-upgrade" ]]; then
  helm upgrade elastic-stack aspenmesh/elastic-stack --namespace ${MONITORING_NAMESPACE}
  exit 0
fi

if [[ $1 = "elastic-stack-remove" ]]; then
  helm uninstall elastic-stack --namespace ${MONITORING_NAMESPACE}
  kubectl delete namespace ${MONITORING_NAMESPACE}
  exit 0
fi


if [[ $1 = "grafana-stack-install" ]]; then
  kubectl create namespace ${MONITORING_NAMESPACE}
  helm install grafana-stack aspenmesh/grafana-stack --namespace ${MONITORING_NAMESPACE}
  exit 0
fi

if [[ $1 = "grafana-stack-upgrade" ]]; then
  helm upgrade grafana-stack aspenmesh/grafana-stack --namespace ${MONITORING_NAMESPACE}
  exit 0
fi

if [[ $1 = "grafana-stack-remove" ]]; then
  helm uninstall grafana-stack --namespace ${MONITORING_NAMESPACE}
  kubectl delete namespace ${MONITORING_NAMESPACE}
  exit 0
fi


if [[ $1 = "kiali-stack-install" ]]; then
  kubectl create namespace ${MONITORING_NAMESPACE}
  helm install kiali-stack aspenmesh/kiali-stack --namespace ${MONITORING_NAMESPACE}
  exit 0
fi

if [[ $1 = "kiali-stack-upgrade" ]]; then
  helm upgrade kiali-stack aspenmesh/kiali-stack --namespace ${MONITORING_NAMESPACE}
  exit 0
fi

if [[ $1 = "kiali-stack-remove" ]]; then
  helm uninstall kiali-stack --namespace ${MONITORING_NAMESPACE}
  kubectl delete namespace ${MONITORING_NAMESPACE}
  exit 0
fi


echo "please specify action ./helm.sh repos/list/elastic-stack-install/elastic-stack-upgrade/elastic-stack-remove/grafana-stack-install/grafana-stack-upgrade/grafana-stack-remove/kiali-stack-install/kiali-stack-upgrade/kiali-stack-remove"
exit 1