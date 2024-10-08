describe('Start Survey', () => {
  it('should offer survey', () => {

    cy.visit('/en')

    // Enter the survey code (from "launchpad")
    cy.get('#access-code').type(`ABCD{enter}`)

    // From intro screen click next and go to first question
    cy.get('[data-cy="start-survey-button"]').contains('Start').click()

    // Answer each of the questions (15 of them)
    for (let i = 0; i < 15; i++) { 
      cy.get('[data-cy="likert-4"]').click()
      cy.get('[data-cy="likert-button-next"]').click()      
    }

    // View the results
    cy.get('[data-cy="button-see-results"]').click()

    // const psResultsCard = cy.get('[data-cy="results-card"]').as('psResultsCard');

    // // Only one graph is shown now
    // cy.get('@psResultsCard').should('have.class', 'card');
    // cy.get('@psResultsCard').find('.card-title').should('contain', 'Psychological Safety');
    // // These need to change now that we have ranges
    // cy.get('@psResultsCard').find('.card-text').should('contain', '35.7');

    // const tmResultsCard = cy.get('[data-cy="tm-results-card"]').as('tmResultsCard');

    // cy.get('@tmResultsCard').should('have.class', 'card');
    // cy.get('@tmResultsCard').find('.card-title').should('contain', 'Total Motivation');
    // cy.get('@tmResultsCard').find('.card-text').should('contain', '-30');

    // const gmResultsCard = cy.get('[data-cy="gm-results-card"]').as('gmResultsCard');

    // cy.get('@gmResultsCard').should('have.class', 'card');
    // cy.get('@gmResultsCard').find('.card-title').should('contain', 'Growth Mindset');
    // cy.get('@gmResultsCard').find('.card-text').should('contain', '31.3');
  })
})
