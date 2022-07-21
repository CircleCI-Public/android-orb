#!/bin/bash
echo ${PARAM_BASE64_KEYSTORE} | base64 -d | tee keystore android/app/keystore > /dev/null