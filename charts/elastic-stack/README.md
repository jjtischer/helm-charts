# Elastic Stack Helm Chart

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Artifact HUB](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/grafana)](https://artifacthub.io/packages/search?repo=grafana)

The code is provided as-is with no warranties.

This Helm Chart contains the following components to monitor an Istio Cluster.

![Elastic Stack Components](./imgs/stack.png "Elastic Stack Components")


|Component|Helm Repo|Version|
|---------|--------|-------|
|Elasticsearch|[elasticsearch](https://helm.elastic.co)|7.15.0|
|Kibana|[kibana](https://helm.elastic.co)|7.15.0|
|APM Server|[apm-server](https://helm.elastic.co)|7.15.0|
|Filebeat|[filebeat](https://helm.elastic.co)|7.15.0|
|Metricbeat|[metricbeat](https://helm.elastic.co)|7.15.0|
|Logstash|[logstash](https://helm.elastic.co)|7.15.0|
|Open Telemetry|[opentelemetry-collector](https://open-telemetry.github.io/opentelemetry-helm-charts)|0.6.0|

## Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```console
# helm repo add aspenmesh https://aspenmesh.github.io/helm-charts
```

You can then run `helm search repo aspenmesh` to see the charts.

```console
# helm search repo aspenmesh/elastic-stack

NAME                    CHART VERSION   APP VERSION     DESCRIPTION                                       
aspenmesh/elastic-stack 0.1.0          1.11.3          A Helm chart for Istio Monitoring with Elastic
```

# Example

This is an example of a clean istio install with IstioOperator and how to link it to the grafana monitoring stack deployed in the `monitoring` namespace.

```console
# istioctl operator init

# kubectl apply -f - <<EOF
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
metadata:
  namespace: istio-system
  name: istiocontrolplane-grafana
spec:
  components: 
    egressGateways: 
    - enabled: true
    ingressGateways: 
    - enabled: true
    pilot:
      enabled: true
  meshConfig:
    accessLogFile: /dev/stdout
    accessLogFormat: |
      [%START_TIME%] "%REQ(:METHOD)% %REQ(X-ENVOY-ORIGINAL-PATH?:PATH)% %PROTOCOL%" %RESPONSE_CODE% %RESPONSE_FLAGS% %RESPONSE_CODE_DETAILS% %CONNECTION_TERMINATION_DETAILS% "%UPSTREAM_TRANSPORT_FAILURE_REASON%" %BYTES_RECEIVED% %BYTES_SENT% %DURATION% %RESP(X-ENVOY-UPSTREAM-SERVICE-TIME)% "%REQ(X-FORWARDED-FOR)%" "%REQ(USER-AGENT)%" "%REQ(X-REQUEST-ID)%" "%REQ(:AUTHORITY)%" "%UPSTREAM_HOST%" %UPSTREAM_CLUSTER% %UPSTREAM_LOCAL_ADDRESS% %DOWNSTREAM_LOCAL_ADDRESS% %DOWNSTREAM_REMOTE_ADDRESS% %REQUESTED_SERVER_NAME% %ROUTE_NAME% traceID=%REQ(x-b3-traceid)%
    enableTracing: true
    defaultConfig:
      tracing:
        sampling: 100
        max_path_tag_length: 99999
        zipkin:
          address: otel-collector.monitoring:9411
  profile: default
EOF

# kubectl create namespace monitoring

# helm install elastic-stack aspenmesh/elastic-stack --namespace monitoring

```

This should result in the following components being installed.

```console
kubectl get po,svc -n monitoring
NAME                                           READY   STATUS    RESTARTS   AGE
pod/fluent-bit-66t6x                           1/1     Running   0          40h
pod/fluent-bit-6bgpc                           1/1     Running   0          40h
pod/fluent-bit-8jbkn                           1/1     Running   0          40h
pod/fluent-bit-f7h5g                           1/1     Running   0          40h
pod/fluent-bit-z6k44                           1/1     Running   0          40h
pod/grafana-87b7c8859-w8fnr                    1/1     Running   0          40h
pod/kube-state-metrics-6777c9bd5-smsz9         1/1     Running   0          40h
pod/loki-0                                     1/1     Running   0          40h
pod/prometheus-86695d8b76-r5788                2/2     Running   0          40h
pod/prometheus-alertmanager-566bddf599-5n8zm   2/2     Running   0          40h
pod/prometheus-node-exporter-qfhxz             1/1     Running   0          40h
pod/prometheus-node-exporter-qht7g             1/1     Running   0          40h
pod/prometheus-node-exporter-slz5d             1/1     Running   0          40h
pod/prometheus-node-exporter-wd5k8             1/1     Running   0          40h
pod/prometheus-node-exporter-wdcpb             1/1     Running   0          40h
pod/tempo-0                                    2/2     Running   0          40h

NAME                               TYPE           CLUSTER-IP       EXTERNAL-IP                                                               PORT(S)                                                                                                    AGE
service/fluent-bit                 ClusterIP      172.20.186.99    <none>                                                                    2020/TCP                                                                                                   40h
service/grafana                    LoadBalancer   172.20.218.68    aaa.eu-west-1.elb.amazonaws.com   80:32487/TCP                                                                                               40h
service/kube-state-metrics         ClusterIP      172.20.149.103   <none>                                                                    8080/TCP                                                                                                   40h
service/loki                       LoadBalancer   172.20.255.92    bbb.eu-west-1.elb.amazonaws.com   3100:32032/TCP                                                                                             40h
service/loki-headless              ClusterIP      None             <none>                                                                    3100/TCP                                                                                                   40h
service/prometheus                 LoadBalancer   172.20.107.186   ccc.eu-west-1.elb.amazonaws.com   80:31990/TCP                                                                                               40h
service/prometheus-alertmanager    ClusterIP      172.20.122.249   <none>                                                                    80/TCP                                                                                                     40h
service/prometheus-node-exporter   ClusterIP      None             <none>                                                                    9100/TCP                                                                                                   40h
service/tempo                      ClusterIP      172.20.215.124   <none>                                                                    3100/TCP,16686/TCP,6831/UDP,6832/UDP,14268/TCP,14250/TCP,9411/TCP,55680/TCP,55681/TCP,4317/TCP,55678/TCP   40h
```

## License

<!-- Keep full URL links to repo files because this README syncs from main to gh-pages.  -->
[Apache 2.0 License](https://github.com/aspenmesh/helm-charts/blob/main/LICENSE).