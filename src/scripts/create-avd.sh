#!/bin/bash

IMAGE=$(eval echo "${ORB_EVAL_PARAM_SYSTEM_IMAGE}")

if [ "${PARAM_INSTALL}" == 1 ]; then
    sdkmanager ${IMAGE}
    echo "installed"

fi

echo "no" | avdmanager --verbose create avd -n ${PARAM_AVD_NAME} -k ${PARAM_SYSTEM_IMAGE} ${PARAM_ADDITIONAL_ARGS}
