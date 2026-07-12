#!/bin/bash

for i in {1..10}; do
    curl -sk https://localhost/healthz
    echo
done

wrk -t4 -c100 -d30s https://localhost/healthz