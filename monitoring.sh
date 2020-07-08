#!/bin/bash

############################################################
## Configurations ##########################################
############################################################
PROMETHEUS_LOCAL_PORT=9090
GRAFANA_LOCAL_PORT=9091


cat <<EOF
############################################################
## Install Prometheus operator with Helm ###################
############################################################
EOF
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo update

kubectl create namespace monitoring
helm install --namespace monitoring --name-template monitoring stable/prometheus-operator \
--set kubelet.serviceMonitor.https=true \
--set prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues=false

cat <<EOF
############################################################
## You can access Prometheus after running below command: ##
############################################################
kubectl --namespace monitoring port-forward services/prometheus-operated $PROMETHEUS_LOCAL_PORT
EOF

cat <<EOF
############################################################
## You can access Grafana after running below command:    ##
############################################################
kubectl --namespace monitoring port-forward services/monitoring-grafana $GRAFANA_LOCAL_PORT:80
EOF

cat <<EOF
############################################################
## Grafana's Admin user password: ##########################
############################################################
EOF
kubectl get secret --namespace monitoring monitoring-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
