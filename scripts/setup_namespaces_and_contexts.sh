#!/bin/bash
set -euo pipefail

echo "=== 🚀 Setting up namespaces and contexts ==="

JENKINS_NS="../1-jenkins-pipelines/k8s/namespaces/jenkins-namespace.yaml"
PIPELINES_NS="../1-jenkins-pipelines/k8s/namespaces/pipelines-namespace.yaml"
SELFSERVICE_NS="../3-self-service-capabilities/k8s/namespaces/selfservice-namespace.yaml"

kubectl apply -f "$JENKINS_NS"
kubectl apply -f "$PIPELINES_NS"
kubectl apply -f "$SELFSERVICE_NS"

if ! kubectl config get-contexts jenkins-context >/dev/null 2>&1; then
  kubectl config set-context jenkins-context --cluster=minikube --namespace=jenkins --user=minikube
fi
if ! kubectl config get-contexts pipelines-context >/dev/null 2>&1; then
  kubectl config set-context pipelines-context --cluster=minikube --namespace=pipelines --user=minikube
fi
if ! kubectl config get-contexts selfservice-context >/dev/null 2>&1; then
  kubectl config set-context selfservice-context --cluster=minikube --namespace=selfservice --user=minikube
fi

echo "=== 🎉 Namespaces and contexts ready ==="
