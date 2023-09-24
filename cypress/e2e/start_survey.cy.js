describe('The Home Page', () => {
  it('start survey', () => {
    cy.visit('/en')

    cy.get('#access-code').type(`ABCD{enter}`)

    // cy.get('').should('contain', `${username}`)
    // cy.get('').should('contain', `${username}`)
  })
})
