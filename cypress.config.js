const { defineConfig } = require('cypress');

module.exports = defineConfig({
  // reporter: './reporters/my-reporter.js',  // Ruta a tu reportero personalizado
  e2e: {
    setupNodeEvents(on, config) {
      on('task', {
        log(message) {
          console.log(message)

          return null
        },
      })
    },
    lang: "es"
  },
});
