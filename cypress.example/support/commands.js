// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --
// Cypress.Commands.add('login', (email, password) => { ... })
//
//
// -- This is a child command --
// Cypress.Commands.add('drag', { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add('dismiss', { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This will overwrite an existing command --
// Cypress.Commands.overwrite('visit', (originalFn, url, options) => { ... })

// https://medium.com/@pipulpant/handling-custom-errors-in-cypress-f1daf1931b64
Cypress.Commands.add('step', description => {
  const MAX_ITEMS_IN_STACK = 5
  const arr = Cypress.env('step') || []
  arr.push(description)
  if (arr.length > MAX_ITEMS_IN_STACK) {
    arr.shift()
  }
  Cypress.env('step', arr)
})
