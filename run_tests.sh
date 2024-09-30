#!/bin/bash

LOG="S"
OUTPUT_FILE="/tmp/cypress_output.log"

function log() {
  if [ "$LOG" == "S" ]; then
    echo "$1"
  fi
}

# Copy the exercise file to the site
function copy_exercise {
  log "Copying exercise to site folder..."
  cp /tmp/exercise ./site/index.html
}


function start_server_in_background {
  log "Starting server..."
  npx http-server ./site -p 8080 -s -c-1 &
  server_pid=$!
  log "Server started with PID $server_pid"
}

function run_tests {
  log "Running tests..."
  npx cypress run --quiet --reporter ./reporters/my-reporter.js > $OUTPUT_FILE
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

function fail() {
  log "Tests failed. Exiting..."
  # TO-DO: generate correctomatic error response
  exit 1
}

# copy_exercise
start_server_in_background
if [[ $? -eq 0 ]]; then
  fail "El servidor no ha podido iniciar"
fi

run_tests

echo "Cypress output:"
cat $OUTPUT_FILE | \
  grep -v '\[STARTED\] Task without title.' | \
  grep -v '\[SUCCESS\] Task without title.'

# Using separators mode, because Cypress output garbage impossible to remove
echo "---BEGIN CORRECTOMATIC RESPONSE---"
echo "(Your response here)"
echo "---END CORRECTOMATIC RESPONSE---"
