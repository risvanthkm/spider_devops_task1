#!/bin/bash

seq 1 50 | xargs -n1 -P10 curl -sk https://localhost/healthz

wrk -t4 -c100 -d30s https://localhost/healthz
