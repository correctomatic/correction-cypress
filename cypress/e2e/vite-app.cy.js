describe('Test page shape', () => {
  // beforeEach(() => {
  //   cy.visit('http://localhost:8080')  // Adjust the URL based on your dev server
  // })

  beforeEach(() => {
    cy.step('Opening the page')
    cy.visit('http://localhost:8080')
    .then($el => {
      cy.task('log', 'This will be output to the terminal')
      cy.log('BANANA!!!')
      // throw new Error('AMAMARLAAAAAAA!!!')
    })
  })

  it.only('displays the correct heading and text', () => {
    cy.step('Testing visibility')
    cy.contains('Hello Vite!').should('be.visible')  // Check heading
    cy.contains('Click on the Vite logo to learn more').should('be.visible')  // Check for footer text
  })

  it('displays the Vite and JS logos', () => {
    cy.get('img').should('have.length', 2)  // Check that there are two images (Vite and JS logos)
  })
})
