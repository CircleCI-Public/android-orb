#!/bin/bash
if [ ${PARAM_GRADLE_CACHE_CHECKSUM} != "/tmp/gradle_cache_seed" ]; then
    echo '${PARAM_GRADLE_CACHE_CHECKSUM}' > ${PARAM_GRADLE_CACHE_CHECKSUM}.txt
fi