#!/bin/bash
run_with_retry() {
            MAX_TRIES=${PARAM_MAX_TRIES}
            n=1
            until [ $n -gt $MAX_TRIES ]
            do
              echo "Starting test attempt $n"
              ${PARAM_TEST_COMMAND} && break
              n=$((n+1))
              sleep "${PARAM_RETRY_INTERVAL}"
            done
            if [ $n -gt $MAX_TRIES ]; then
              echo "Max tries reached (${PARAM_MAX_TRIES})"
              exit 1
            fi
        }
        run_with_retry