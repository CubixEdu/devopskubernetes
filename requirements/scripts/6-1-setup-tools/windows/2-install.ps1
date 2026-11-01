kubectl create ns tools
kubectl create configmap grafana-datasources --from-file=../datasources.yaml -n tools
kubectl label cm/grafana-datasources grafana_datasource=true -n tools
kubectl create secret generic grafana-admin-login --from-literal=user=admin --from-literal=password=admin -n tools
helm install prometheus prometheus-community/kube-prometheus-stack -f ../prometheus.yaml --version 92.11.0 -n tools
helm install alloy grafana/alloy -f ../alloy.yaml --version 1.14.2 -n tools
helm install loki grafana-community/loki -f ../loki.yaml --version 19.1.1 -n tools
helm install tempo grafana-community/tempo -f ../tempo.yaml --version 3.2.1 -n tools
helm install grafana grafana-community/grafana -f ../grafana.yaml --version 14.0.1 -n tools
