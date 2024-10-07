const { defineConfig } = require('cypress');

module.exports = defineConfig({
  // reporter: './reporters/my-reporter.js',  // Ruta a tu reportero personalizado
  e2e: {
    defaultCommandTimeout: 500,
    pageLoadTimeout: 2000,
    setupNodeEvents(on, config) {
      on('task', {
        log(message) {
          console.log(message)

          return null
        },
      })
    },
  },
});
