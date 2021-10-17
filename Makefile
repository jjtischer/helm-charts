# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help


################
#### CHARTS ####
################

charts-package:  ## Package Helm charts
	./scripts/charts.sh package

charts-upload: ## Upload Helm chart packages to GitHub Release
	./scripts/charts.sh upload

charts-index: ## Update Helm repo index.yaml for the given GitHub repo
	./scripts/charts.sh index


#################
#### AWS EKS ####
#################

awscli-login: ## Login to AWS CLI
	./scripts/aws.sh login

eks-create-cluster: ## Create k8s cluster using eksctl
	./scripts/aws.sh create

eks-delete-cluster: ## Delete k8s cluster using eksctl
	./scripts/aws.sh delete

eks-info-cluster: ## Get k8s cluster information using kubectl
	./scripts/aws.sh info

eks-external-services: ## Get external services for eks cluster
	./scripts/aws.sh external-services


#################
##### ISTIO #####
#################

istio-operator: ## Install Istio Operator
	./scripts/istio.sh install-operator

istio-istioctl: ## Install istioctl binary
	./scripts/istio.sh istioctl

istio-elastic-stack: ## Install Istio with Elastic Stack configured
	./scripts/istio.sh install-elastic-stack

istio-grafana-stack: ## Install Istio with Grafana Stack configured
	./scripts/istio.sh install-grafana-stack

istio-kiali-stack: ## Install Istio with Kiali Stack configured
	./scripts/istio.sh install-kiali-stack


################
##### HELM #####
################

helm-repos: ## Install and update Helm Repos
	./scripts/helm.sh repos


helm-list: ## List the charts in aspenmesh Helm Repo
	./scripts/helm.sh list



helm-elastic-stack-install: ## Install Elastic Monitoring Stack
	./scripts/helm.sh elastic-stack-install

helm-elastic-stack-upgrade: ## Upgrade Elastic Monitoring Stack
	./scripts/helm.sh elastic-stack-upgrade

helm-elastic-stack-remove: ## Remove Elastic Monitoring Stack
	./scripts/helm.sh elastic-stack-remove



helm-grafana-stack-install: ## Install Grafana Monitoring Stack
	./scripts/helm.sh grafana-stack-install

helm-grafana-stack-upgrade: ## Upgrade Grafana Monitoring Stack
	./scripts/helm.sh grafana-stack-upgrade

helm-grafana-stack-remove: ## Remove Grafana Monitoring Stack
	./scripts/helm.sh grafana-stack-remove



helm-kiali-stack-install: ## Install Kiali Monitoring Stack
	./scripts/helm.sh kiali-stack-install

helm-kiali-stack-upgrade: ## Upgrade Kiali Monitoring Stack
	./scripts/helm.sh kiali-stack-upgrade

helm-kiali-stack-remove: ## Remove Kiali Monitoring Stack
	./scripts/helm.sh kiali-stack-remove
