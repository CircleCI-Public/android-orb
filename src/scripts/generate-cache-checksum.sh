#!/bin/bash
find ${PARAM_FIND_ARGS} | sort | xargs cat |
shasum | awk '{print $1}' > /tmp/gradle_cache_seed