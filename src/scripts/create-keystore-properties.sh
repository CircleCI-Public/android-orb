#!/bin/bash
printf 'releaseKeyAlias=%s\nreleaseKeyPassword=%s\nreleaseKeyStore=%s\nreleaseStorePassword=%s' \
            ${PARAM_RELEASE_KEY_ALIAS} ${PARAM_RELEASE_KEY_PASSWORD} ${PARAM_RELEASE_KEYSTORE} ${PARAM_RELEASE_STORE_PASSWORD} > keystore.properties