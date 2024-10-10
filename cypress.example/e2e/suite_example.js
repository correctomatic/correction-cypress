describe('Example of a test suite', () => {

  beforeEach(() => {
    // This will use the baseUrl set in cypress.json
    cy.visit('/')
  })

  // Put here the fail fast tests: single errors that will guide the student
  // (for example: shape of the page, required elements, etc.)
  // If the exercise doesn't do this, it can't even be corrected
  // The student will only see the first failed test here
  describe('Preconditions', { failFast: { enabled: true } }, () => {
    it('The page must have exactly 10 <p> elements', () => {
      cy.get('p').should('have.length', 10)
    })
  })

  // Put here the tests that will be used to correct the exercise
  // The student will see the results of all failed tests here
  // This will run only if the precondition tests are met
  describe('Tests', () => {
    it('Do something useful', () => {
      cy.get('button').click()
      cy.get('p').should('have.length', 10)
    })
  })

})
