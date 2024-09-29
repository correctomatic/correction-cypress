describe('Vite App Tests', () => {
  beforeEach(() => {
    cy.visit('http://localhost:8080');  // Adjust the URL based on your dev server
  });

  it('displays the correct heading and text', () => {
    cy.contains('Hello Vite!').should('be.visible');  // Check heading
    cy.contains('Click on the Vite logo to learn more').should('be.visible');  // Check for footer text
  });

  it('has working counter', () => {
    cy.get('button').contains('count is').should('be.visible');  // Check for counter button
    cy.get('button').click().contains('count is 1');  // Click and check if count increases
  });

  it('displays the Vite and JS logos', () => {
    cy.get('img').should('have.length', 2);  // Check that there are two images (Vite and JS logos)
  });
});
