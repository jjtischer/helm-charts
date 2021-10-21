# Aspen Mesh Demo Istio Helm Charts

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Artifact HUB](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/grafana)](https://artifacthub.io/packages/search?repo=grafana)

The code is provided as-is with no warranties.

## Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```console
helm repo add aspenmesh https://aspenmesh.github.io/helm-charts
```

You can then run `helm search repo aspenmesh` to see the charts.

### Charts

This is a list of available charts.

|Chart|Release|Docs|Description|
|-----|-------|----|-----------|
|elastic-stack|[0.12.0](https://github.com/aspenmesh/helm-charts/releases/tag/elastic-stack-0.2.0)|[doc](charts/elastic-stack/README.md)|Istio Monitoring with Elastic Search, Kibana, APM Server and Filebeat|
|grafana-stack|[0.12.0](https://github.com/aspenmesh/helm-charts/releases/tag/grafana-stack-0.12.0)|[doc](charts/grafana-stack/README.md)|Istio Monitoring with Kiali, Grafana, Prometheus and Jaeger|
|kiali-stack|[0.12.0](https://github.com/aspenmesh/helm-charts/releases/tag/kiali-stack-0.12.0)|[doc](charts/kiali-stack/README.md)|Istio Monitoring with Prometheus, Grafana, Tempo, Loki and FluentBit|


## License

<!-- Keep full URL links to repo files because this README syncs from main to gh-pages.  -->
[Apache 2.0 License](https://github.com/aspenmesh/helm-charts/blob/main/LICENSE).