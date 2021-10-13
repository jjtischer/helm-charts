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
	./scripts/istio.sh install

istio-istioctl: ## Install istioctl binary
	./scripts/istio.sh istioctl


################
##### HELM #####
################

helm-repos: ## Install and update Helm Repos
	./scripts/helm.sh repos

helm-grafana-stack: ## Install Grafana Monitoring Stack
	./scripts/helm.sh grafana-stack

helm-kiali-stack: ## Install Kiali Monitoring Stack
	./scripts/helm.sh kiali-stack
