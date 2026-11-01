#!/bin/sh

kind create cluster --config ../cluster.yaml
helm install nginx-ingress oci://ghcr.io/nginx/charts/nginx-ingress --version 2.8.0 -n ingress-nginx --create-namespace -f ../controller-values.yaml
