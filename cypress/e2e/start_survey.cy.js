describe('The Home Page', () => {
  it('start survey', () => {
    cy.visit('/en')

    // Enter the survey code (from "launchpad")
    cy.get('#access-code').type(`ABCD{enter}`)

    // From intro screen click next and go to first question
    cy.get('[data-cy="start-survey-button"]').contains('Next')
    cy.get('[data-cy="start-survey-button"]').click()

    // Answer each of the questions (15 of them)
    for (let i = 0; i < 15; i++) { 
      cy.get('[data-cy="likert-4"]').click()
      cy.get('[data-cy="likert-button-next"]').click()      
    }

    // View the results
    cy.get('[data-cy="button-see-results"]').click()

    cy.get('[data-cy="ps-results-card"]').should('have.class', 'card')
    cy.get('[data-cy="tm-results-card"]').should('have.class', 'card')
    cy.get('[data-cy="gm-results-card"]').should('have.class', 'card')
  })
})
