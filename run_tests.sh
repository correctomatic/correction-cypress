#!/bin/bash

# Copy the exercise file to the site
function copy_exercise {
  cp /tmp/exercise ./site/index.html
}

echo "Starting server..."
# -c-1 is to disable cache
npx http-server ./site -p 8080 -s -c-1 &

# npx cypress run --quiet --reporter ./reporters/my-reporter.js \
#       2> /dev/null \
#       | grep -v '\[STARTED\] Task without title.' | grep -v '\[SUCCESS\] Task without title.'

echo "Starting tests..."

output_file="/tmp/output.log"

NODE_OPTIONS="--no-warnings" NODE_NO_WARNINGS=1 npx cypress run --quiet --reporter ./reporters/my-reporter.js 2> /dev/null > $output_file

if [ $? -eq 0 ]; then
  echo "All tests passed!"
else
  echo "Some tests failed."
fi

echo "Cypress output:"
cat $output_file | \
  grep -v '\[STARTED\] Task without title.' | \
  grep -v '\[SUCCESS\] Task without title.'

# Using separators mode, because Cypress output garbage impossible to remove
echo "---BEGIN CORRECTOMATIC RESPONSE---"
echo "(Your response here)"
echo "---END CORRECTOMATIC RESPONSE---"
