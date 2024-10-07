
function safeStringify(obj, spaces=2) {
  const cache = new WeakSet()
  return JSON.stringify(obj, (key, value) => {
    if (typeof value === 'object' && value !== null) {
      if (cache.has(value)) {
        return // Circular reference found, discard key
      }
      cache.add(value)
    }
    return value
  }, spaces)
}

const createCustomErrorMessage = (error, steps, runnableObj) => {
  let lastSteps = "Last logged steps:\n"

  steps.map((step, index) => {
    lastSteps += `${index + 1}. ${step}\n`
  })

  return 'BANANA!!!'
  return safeStringify(runnableObj.parent)
  return runnableObj.parent.title
  return runnableObj.title
  return safeStringify(runnableObj)
  const messageArr = [
    `Context: ${runnableObj.parent.title}`,
    `Test: ${runnableObj.title}`,
    `----------`,
    `${error.message}`,
    `\n${lastSteps}`,
  ]
  return messageArr.join('\n')
}

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
    // cy.contains('Hello Vite!').should('be.visible')  // Check heading

    cy.contains('Hello Vite!').then( function ($el) {
      cy.task('log', 'Inside contains')
      cy.task('log', $el)
      const errorMessage = createCustomErrorMessage(
        new Error(`Expected element to be visible: ${$el.selector}`),
        Cypress.env('step'),
        this
      )
      // expect($el,errorMessage).not.to.be.visible()
      expect($el, 'Terrible failure!!!').to.have.css('color', 'rgb(0, 0, 0)',)
      // expect($el).to.have('ASEREJE!!!').css('color', 'rgb(0, 0, 0)',)
    })

    // cy.contains('Click on the Vite logo to learn more').should('be.visible')  // Check for footer text
  })

  it('displays the Vite and JS logos', () => {
    cy.get('img').should('have.length', 2)  // Check that there are two images (Vite and JS logos)
  })
})
