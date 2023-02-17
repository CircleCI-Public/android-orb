#!/bin/bash

IMAGE=$(eval echo "${PARAM_SYSTEM_IMAGE}")

echo "${ORB_EVAL_PARAM_SYSTEM_IMAGE}"

if [ "${PARAM_INSTALL}" == 1 ]; then
    sdkmanager "$IMAGE"

fi

echo "no" | avdmanager --verbose create avd -n ${PARAM_AVD_NAME} -k "$IMAGE" ${PARAM_ADDITIONAL_ARGS}
