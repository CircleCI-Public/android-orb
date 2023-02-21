#!/bin/bash

IMAGE=$(eval echo ${ORB_EVAL_[PARAM_SYSTEM_IMAGE]})

if [ "${PARAM_INSTALL}" == 1 ]; then
    sdkmanager ${IMAGE}
    echo ${IMAGE}
    echo "${IMAGE}"
    echo $IMAGE
    echo "installed"

fi

echo "no" | avdmanager --verbose create avd -n ${PARAM_AVD_NAME} -k ${PARAM_SYSTEM_IMAGE} ${PARAM_ADDITIONAL_ARGS}
