#!/bin/sh

kubectl create ns tools
kubectl create configmap grafana-datasources --from-file=../datasources.yaml -n tools
kubectl label cm/grafana-datasources grafana_datasource=true -n tools
kubectl create secret generic grafana-admin-login --from-literal=user=admin --from-literal=password=admin -n tools
helm install prometheus prometheus-community/kube-prometheus-stack -f ../prometheus.yaml --version 56.9.0 -n tools
helm install promtail grafana/promtail -f ../promtail.yaml --version 6.15.5 -n tools
helm install loki grafana/loki -f ../loki.yaml --version 5.43.3 -n tools
helm install tempo grafana/tempo -f ../tempo.yaml --version 1.7.2 -n tools
helm install grafana grafana/grafana -f ../grafana.yaml --version 7.3.2 -n tools
