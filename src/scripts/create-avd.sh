#!/bin/bash

SYSTEM_IMAGE='${!PARAM_SYSTEM_IMAGE}'

echo $SYSTEM_IMAGE
echo $PARAM_SYSTEM_IMAGE

if [ "${PARAM_INSTALL}" == 1 ]; then
    sdkmanager "$SYSTEM_IMAGE"

fi

echo "no" | avdmanager --verbose create avd -n ${PARAM_AVD_NAME} -k "$SYSTEM_IMAGE" ${PARAM_ADDITIONAL_ARGS}
