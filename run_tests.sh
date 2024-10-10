#!/usr/bin/env bash

LOG="N" # Y/N
OUTPUT_FILE="/tmp/cypress_output.log"
DEFAULT_SUCCESS_MESSAGE="Good job! All tests passed."

function log() {
  if [ "$LOG" == "Y" ]; then
    echo "$1"
  fi
}

escape_json() {
  # Use jq to escape the input
  echo -n "$1" | jq -s -R '.'
}

function enclose_in_separators() {
  # Using separators mode, because Cypress generates garbage impossible to remove
  echo "---BEGIN CORRECTOMATIC RESPONSE---"
  echo "$1"
  echo "---END CORRECTOMATIC RESPONSE---"
}

function success_response() {
  GRADE=$1
  COMMENT=$(escape_json "$2")
  json=$(
    cat <<EOF
{
  "success": true,
  "grade": $GRADE,
  "comments": [
    $COMMENT
  ]
}
EOF
  )
  enclose_in_separators "$json"
}

function error_response() {
  ERROR=$(escape_json "$1")
  json=$(
    cat <<EOF
{
  "success": false,
  "error": $ERROR
}
EOF
  )

  enclose_in_separators "$json"
}

function fail() {
  log "$1"
  error_response "$1"
  exit 1
}

# Copy the exercise file to the site
function copy_exercise {
  log "Copying exercise to site folder..."
  mkdir -p ./site
  cp /tmp/exercise ./site/index.html
}

function start_server_in_background {
  log "Starting server..."
  npx http-server ./site -p 8080 -s -c-1 &
  server_pid=$!
  [[ $? -ne 0 ]] && return 1

  log "Server started with PID $server_pid"
  return 0
}

function run_tests {
  log "Running tests..."
  npx cypress run --quiet --reporter ./reporters/correctomatic-reporter.js >$OUTPUT_FILE
  return $?
}

function get_clean_output() {
  cat $OUTPUT_FILE |
    grep -v '\[STARTED\] Task without title.' |
    grep -v '\[SUCCESS\] Task without title.' |
    sed '/^\[fail-fast\]/d'
}

function extract_tests_result {
  CLEAN_OUTPUT="$(get_clean_output)"  # Obtener la salida limpia

  # We need to distinguish between the case where the tests failed and the case
  # where the cypress process failed.
  # If the run could complete, the output will be enclosed between:
  # ----------TESTS STARTED----------
  # ... results ....
  # ----------TESTS FINISHED----------
  # If not, Cypress failed to run the tests somehow

  if [[ $CLEAN_OUTPUT =~ ----------TESTS\ STARTED----------(.*?)----------TESTS\ FINISHED---------- ]]; then
    TEST_RESULTS=$(echo "${BASH_REMATCH[1]}" | awk 'NF')
    echo -n "$TEST_RESULTS"
  else
    log "Cypress execution failed"
    return 1
  fi
}

function main() {
  copy_exercise
  start_server_in_background
  if [[ $? -ne 0 ]]; then
    fail "El servidor no ha podido iniciar"
  fi

  run_tests
  TESTS_EXIT_CODE=$?

  if [[ TESTS_EXIT_CODE -eq 0 ]]; then
    # All tests passed
    success_response 10 "${SUCCESS_MESSAGE:-$DEFAULT_SUCCESS_MESSAGE}"
  else
    TEST_RESULT="$(extract_tests_result)"
    TESTS_EXIT_CODE=$?
    if [[ $TESTS_EXIT_CODE -ne 0 ]]; then
      fail "Error running the correction"
    fi
    success_response 0 "$TEST_RESULT"
  fi

}

source .env
main
