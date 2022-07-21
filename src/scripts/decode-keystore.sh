#!/bin/bash

PARAM_BASE64_KEYSTORE=$(eval echo "\$$PARAM_BASE64_KEYSTORE")

echo "$PARAM_BASE64_KEYSTORE" | base64 -di | tee keystore "${PARAM_KEYSTORE_LOCATION}" > /dev/null
