#!/bin/bash
find ${PARAM_FIND_ARGS} | sort | xargs cat |
shasum | awk '{print $1}' > ${PARAM_GRADLE_CACHE_CHECKSUM}
