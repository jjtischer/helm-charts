

versions=( 1.9.0 1.9.1 1.9.2 1.9.3 1.9.4 1.9.5 1.9.6 1.9.7 1.9.8 1.9.9 1.10.0 1.10.1 1.10.2 1.10.3 1.10.4 1.10.5 1.11.0 1.11.1 1.11.2 1.11.3 )

for version in "${versions[@]}"
do
  echo "========== Istio version ${version} =========="
  rm -rf /Users/vanbos/Documents/Git/aspenmesh/helm-charts/charts/istio/*
  # rm -rf .cr-release-packages/*.tgz

	cp -R /Users/vanbos/Documents/Git/istio/istio-${version}/manifests/charts/* /Users/vanbos/Documents/Git/aspenmesh/helm-charts/charts/istio/
  cr package charts/istio/base
  cr package charts/istio/istio-operator
  cr package charts/istio/istio-cni
  cr package charts/istio/istiod-remote
  cr package charts/istio/istio-control/istio-discovery
  cr package charts/istio/gateways/istio-ingress
  cr package charts/istio/gateways/istio-egress
  
  cr upload -o aspenmesh --git-repo helm-charts --token ${GITHUB_TOKEN}
  # cr index -o aspenmesh --git-repo helm-charts --charts-repo https://aspenmesh.github.io/helm-charts
  # cp .cr-index/index.yaml ./index.yaml
  
  # git add -A 
  # git commit -a -m "Added istio helm charts for version ${version}"
  # git push
done

