#!/bin/bash

LOG="S"
OUTPUT_FILE="/tmp/cypress_output.log"

function log() {
  if [ "$LOG" == "S" ]; then
    echo "$1"
  fi
}

escape_json() {
  local input="$1"
  # Escapar comillas dobles, barra invertida y caracteres especiales
  input=$(echo "$input" | sed 's/\\/\\\\/g' | sed 's/"/\\"/g' | sed 's/\n/\\n/g' | sed 's/\r/\\r/g' | sed 's/\t/\\t/g')
  echo "$input"
}

function enclose_in_separators() {
  echo "---BEGIN CORRECTOMATIC RESPONSE---"
  echo "$1"
  echo "---END CORRECTOMATIC RESPONSE---"
}

function success_response() {
  # Using separators mode, because Cypress generates garbage impossible to remove
  GRADE=$1
  COMMENT=$(escape_json "$2")
  json=$(cat <<EOF
{
  "success": true,
  "grade": $GRADE,
  "comments": [
    "$COMMENT"
  ]
}
EOF
)
  enclose_in_separators "$json"
}

function error_response() {
  # Using separators mode, because Cypress generates garbage impossible to remove
  echo "---BEGIN CORRECTOMATIC RESPONSE---"
  echo "Some tests failed."
  echo "---END CORRECTOMATIC RESPONSE---"
}

# Copy the exercise file to the site
function copy_exercise {
  log "Copying exercise to site folder..."
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

function correctomatic_response() {
  # Using separators mode, because Cypress generates garbage impossible to remove
  echo "---BEGIN CORRECTOMATIC RESPONSE---"
  echo "$1"
  echo "---END CORRECTOMATIC RESPONSE---"
}

function fail() {
  log "$1"
  # TO-DO: generate correctomatic error response
  exit 1
}

killall http-server
# copy_exercise
start_server_in_background
if [[ $? -ne 0 ]]; then
  fail "El servidor no ha podido iniciar"
fi

run_tests
if [[ $? -eq 0 ]]; then
  success_response 10 'Buen trabajo'
else
  error_response 0 `cat $OUTPUT_FILE`
fi


