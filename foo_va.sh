#!/bin/bash
OUTPUT_FILE="/tmp/cypress_output.log"


function success_response() {
  GRADE=$1
  COMMENT=$2
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
  echo "$json"
}

function get_clean_output() {
  cat $OUTPUT_FILE | \
    grep -v '\[STARTED\] Task without title.' | \
    grep -v '\[SUCCESS\] Task without title.'
}


success_response 0 "$(get_clean_output)"
