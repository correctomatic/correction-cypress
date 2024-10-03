#!/bin/bash
OUTPUT_FILE="/tmp/cypress_output.log"



escape_json_1() {
  local input="$1"
  # Escape double quotes, backslashes, and special characters while preserving newlines
  echo "$input" | awk 'BEGIN { ORS="" } {
    gsub(/\\/, "\\\\");
    gsub(/"/, "\\\"");
    gsub(/\n/, "\\n");
    gsub(/\r/, "\\r");
    gsub(/\t/, "\\t");
    printf "%s", $0
  }'
}


escape_json() {
  local input="$1"
  # Escape double quotes, backslashes, and special characters while preserving newlines
  echo "$input" | awk '{
    gsub(/\\/, "\\\\");
    gsub(/"/, "\\\"");
    printf "%s\\n", $0
  }'
}


function success_response() {
  GRADE=$1
  # COMMENT=$2
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
  echo "$json"
}

function get_clean_output() {
  cat $OUTPUT_FILE | \
    grep -v '\[STARTED\] Task without title.' | \
    grep -v '\[SUCCESS\] Task without title.'
}


success_response 0 "$(get_clean_output)"
