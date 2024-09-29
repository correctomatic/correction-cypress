describe('Test page behaviour', () => {
  beforeEach(() => {
    cy.visit('http://localhost:8080')  // Adjust the URL based on your dev server
  })

  it('has working counter', () => {
    cy.get('button').contains('count is').should('be.visible')  // Check for counter button
    cy.get('button').click().contains('count is 3')  // Click and check if count increases
  })

})
