
Cypress.Commands.add(
  'login', (username, password) => {
    cy.visit('/en/admin')

    cy.get('#input-email').type(username)
    cy.get('#input-password').type(`${password}{enter}`)
  }
)
