#!/usr/bin/env bash

LOG="N"
OUTPUT_FILE="/tmp/cypress_output.log"

function log() {
  if [ "$LOG" == "S" ]; then
    echo "$1"
  fi
}

escape_json() {
  # Use jq to escape the input
  echo "$1" | jq -R -s '.'
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
  json=$(cat <<EOF
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
  json=$(cat <<EOF
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
  npx http-server ./site -p 8080 -s -c-1 & server_pid=$!
  [[ $? -ne 0 ]] && return 1

  log "Server started with PID $server_pid"
  return 0
}

function run_tests {
  log "Running tests..."
  npx cypress run --quiet --reporter ./reporters/correctomatic-reporter.js > $OUTPUT_FILE
  tests_exit_code=$?

  log "Tests exit code: $tests_exit_code"
  if [ $tests_exit_code -eq 0 ]; then
    log "All tests passed!"
    return 0
  else
    log "Some tests failed."
    return 1
  fi
}

function get_clean_output() {
  cat $OUTPUT_FILE | \
    grep -v '\[STARTED\] Task without title.' | \
    grep -v '\[SUCCESS\] Task without title.'
}

copy_exercise
start_server_in_background
if [[ $? -ne 0 ]]; then
  fail "El servidor no ha podido iniciar"
fi

run_tests
if [[ $? -eq 0 ]]; then
  success_response 10 'Buen trabajo'
else
  success_response 0 "$(get_clean_output)"
fi
