#!/bin/bash

set -euo pipefail

namespace="$1"

if [ -z "$namespace" ]; then
    echo "Usage: create-ephemeral-values.sh <namespace>"
    exit 1
fi

cat << EOF > deploy/ephemeral/${namespace}.values.yml
ingress:
  enabled: true
  annotations:
    kubernetes.io/ingress.class: nginx-ingress
    certmanager.k8s.io/cluster-issuer: letsencrypt-prod
  paths:
    - /
  hosts:
    - host: ${namespace}.bb-gke.hillghost.com
      paths: ["/"]
  tls:
    - secretName: delicate-flowers-cert
      hosts:
        - ${namespace}.bb-gke.hillghost.com
EOF