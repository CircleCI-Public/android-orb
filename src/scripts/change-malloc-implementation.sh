#!/bin/bash

if [[ ${PARAM_IMPLEMENTATION} == "jemalloc" ]]; then
    sudo apt install libjemalloc-dev
    echo "LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2" | sudo tee -a /etc/environment
else
    sudo apt install google-perftools
    echo "LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libtcmalloc.so.4" | sudo tee -a /etc/environment
fi
