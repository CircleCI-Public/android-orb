#!/bin/bash
echo "The following are the files used to generate the cache checksum:"
eval find "${PARAM_FIND_ARGS}"
eval find "${PARAM_FIND_ARGS}" | sort | xargs cat |
shasum | awk '{print $1}' > /tmp/gradle_cache_seed 
