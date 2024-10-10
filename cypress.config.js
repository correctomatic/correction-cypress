// This must be in the root of the project, not in the cypress folder
const { defineConfig } = require('cypress');
const failFast = require('cypress-fail-fast/plugin');

module.exports = defineConfig({
  e2e: {
    defaultCommandTimeout: 500,
    pageLoadTimeout: 500,
    // The base container start the server on port 8080
    baseUrl: 'http://localhost:8080',
    env: {
      "FAIL_FAST_STRATEGY": "run",
      "FAIL_FAST_ENABLED": false, // You would usually want to enable it in some tests only
      // "FAIL_FAST_PLUGIN": false // Completely disable the plugin if true
    },
    setupNodeEvents(on, config) {
      failFast(on, config);
      on('task', {
        log(message) {
          console.log(message)
          return null
        },
      })
      // This is MANDATORY for the base container to work
      on('before:run', () => {
        console.log('----------TESTS STARTED----------')
      });
      on('after:run', () => {
        console.log('----------TESTS FINISHED----------')
      });
      return config
    },
  },
});
