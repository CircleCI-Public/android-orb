#!/bin/bash
PARAM_PRE_TEST_COMMAND="$(echo "$PARAM_PRE_TEST_COMMAND" | circleci env subst "$PARAM_PRE_TEST_COMMAND")"
PARAM_TEST_COMMAND="$(echo "$PARAM_TEST_COMMAND" | circleci env subst "$PARAM_TEST_COMMAND")"

run_with_retry() {
  MAX_TRIES=${PARAM_MAX_TRIES}
  n=1
  until [ $n -gt $MAX_TRIES ]; do
    echo "Starting test attempt $n"
    eval "${PARAM_PRE_TEST_COMMAND}"
    eval "${PARAM_TEST_COMMAND}" && break
    n=$((n + 1))
    sleep "${PARAM_RETRY_INTERVAL}"
  done
  if [ $n -gt $MAX_TRIES ]; then
    echo "Max tries reached (${PARAM_MAX_TRIES})"
    exit 1
  fi
}
run_with_retry
