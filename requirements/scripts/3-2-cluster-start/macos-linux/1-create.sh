#!/bin/sh

kind create cluster --config ../cluster.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/refs/tags/controller-v1.14.0/deploy/static/provider/kind/deploy.yaml
