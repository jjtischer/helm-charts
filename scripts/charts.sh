#!/usr/bin/env bash

ROOT_DIR=$(pwd)
source ${ROOT_DIR}/scripts/environment.sh
set -o xtrace

if [[ $1 = "package" ]]; then
  cr package charts/elastic-stack
  cr package charts/grafana-stack
  cr package charts/kiali-stack
  exit 0
fi

if [[ $1 = "upload" ]]; then
  echo "What is your github token? "
  read -r GITHUB_TOKEN
  cr upload -o aspenmesh --git-repo helm-charts --token ${GITHUB_TOKEN}
  exit 0
fi

if [[ $1 = "index" ]]; then
  echo "What is your github token? "
  read -r GITHUB_TOKEN
  cr index -o aspenmesh --git-repo helm-charts --charts-repo https://aspenmesh.github.io/helm-charts --token ${GITHUB_TOKEN}
  exit 0
fi

echo "please specify action ./charts.sh package/upload/index"
exit 1