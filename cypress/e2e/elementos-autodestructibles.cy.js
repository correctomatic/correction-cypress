describe('Test de interacciones con párrafos y botón Reaparecer', () => {

  beforeEach(() => {
    // Visita la página que contiene el programa
    cy.visit('http://localhost:8080');
  });

  it('Debe haber 10 elementos <p>', () => {
    cy.get('p').should('have.length', 10);
  });

  it('Debe ocultar el <p> al hacer clic', () => {
    cy.get('p').each(($p) => {
      cy.wrap($p).click();
      cy.wrap($p).should('not.be.visible');
    });
  });

  it('Debe eliminar el <p> del DOM al hacer clic derecho', () => {
    cy.get('p').each(($p) => {
      cy.wrap($p).trigger('contextmenu');
      cy.wrap($p).should('not.exist');
    });
  });

  it('Debe reaparecer los párrafos ocultos al hacer clic en el botón "Reaparecer"', () => {
    // Primero ocultamos los párrafos
    cy.get('p').each(($p) => {
      cy.wrap($p).click();
    });

    // Verificamos que no sean visibles
    cy.get('p').each(($p) => {
      cy.wrap($p).should('not.be.visible');
    });

    // Hacemos clic en el botón "Reaparecer"
    cy.contains('button', 'Reaparecer').click();

    // Verificamos que los párrafos ocultos reaparezcan (los eliminados no)
    cy.get('p').each(($p) => {
      cy.wrap($p).should('be.visible');
    });
  });

});
