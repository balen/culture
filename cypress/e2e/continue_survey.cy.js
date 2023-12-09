describe('Continue Survey', () => {
    it('should offer to answer more questions', () => {
  
      cy.visit('/en')
  
      // Enter the survey code (from "launchpad")
      cy.get('#access-code').type(`ABCD{enter}`)
  
      // From intro screen click next and go to first question
      cy.get('[data-cy="start-survey-button"]').click()
  
      // Skip all the questions (15 of them)
      for (let i = 0; i < 15; i++) { 
        cy.get('[data-cy="likert-button-next"]').click()      
      }
  
      // View the results
      cy.get('[data-cy="button-see-results"]').click()
  
      cy.get('[data-cy="start-survey-button"]').contains("more").click()
      
      // Answer each of the questions (15 of them)
      for (let i = 0; i < 15; i++) { 
        cy.get('[data-cy="likert-4"]').click()
        cy.get('[data-cy="likert-button-next"]').click()      
      }
  
      // View the results
      cy.get('[data-cy="button-see-results"]').click()
  
      const psResultsCard = cy.get('[data-cy="ps-results-card"]').as('psResultsCard');
      
      // Only one graph is shown now
      cy.get('@psResultsCard').should('have.class', 'card');
      cy.get('@psResultsCard').find('.card-title').should('contain', 'Psychological Safety');
      // These need to change now that we have ranges
      cy.get('@psResultsCard').find('.card-text').should('contain', '35.7');
    })
  })
  