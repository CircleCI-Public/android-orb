#!/bin/bash

echo $PARAM_SYSTEM_IMAGE

if [ "${PARAM_INSTALL}" == 1 ]; then
    sdkmanager $PARAM_SYSTEM_IMAGE

fi

echo "no" | avdmanager --verbose create avd -n ${PARAM_AVD_NAME} -k $PARAM_SYSTEM_IMAGE ${PARAM_ADDITIONAL_ARGS}
