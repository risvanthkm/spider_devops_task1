#!/bin/bash

for i in {1..10}; do
    curl -sk https://localhost/healthz
    echo
    sleep 1
done

wrk -t4 -c100 -d30s https://localhost/healthz
