#!/bin/bash
PARAM_AVD_NAME="$(echo "$PARAM_AVD_NAME" | circleci env subst "$PARAM_AVD_NAME")"
PARAM_SYSTEM_IMAGE="$(echo "$PARAM_SYSTEM_IMAGE" | circleci env subst "$PARAM_SYSTEM_IMAGE")"
PARAM_ADDITIONAL_ARGS="$(echo "$PARAM_ADDITIONAL_ARGS" | circleci env subst "$PARAM_ADDITIONAL_ARGS")"

if [ "${PARAM_INSTALL}" == 1 ]; then
    sdkmanager "${PARAM_SYSTEM_IMAGE}"
fi

echo "no" | avdmanager --verbose create avd -n ${PARAM_AVD_NAME} -k ${PARAM_SYSTEM_IMAGE} ${PARAM_ADDITIONAL_ARGS}
