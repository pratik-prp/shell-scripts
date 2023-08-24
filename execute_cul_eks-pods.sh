#!/bin/bash

namespace='prod'
service_name=$1
curl_arguments=$2
echo $curl_arguments
pods=$(kubectl get pods -n $namespace -l app=$service_name -o jsonpath='{.items[*].metadata.name}')
echo "--------------------------------------"
echo $pods
echo "--------------------------------------"
for pod in $pods; do
    echo "Executing curl on pod: $pod"
    kubectl exec -it $pod -n $namespace -- $curl_arguments
    echo "--------------------------------------"
done
