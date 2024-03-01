const { transformVNodeArgs } = require("vue")

describe('Continue Survey', () => {
  it('should offer more questions and cover P2T, PTW and CB', () => {
    cy.visit('/en')

    // Enter the survey code (from "launchpad")
    cy.get('#access-code').type(`ABCD{enter}`)

    // From intro screen click next and go to first question
    cy.get('[data-cy="start-survey-button"]').click()

    // These words need to be verified for the test
    const wordsToCheck = {
      "need": false, "concerned": false, "believe": false, "lying": false,
      "rely": false, "confidence": false, "keep their word": false, "hidden agenda": false,
      "climate": false
    };

    // Function to check for words in the current question
    const checkWordsInCurrentQuestion = () => {
      Object.keys(wordsToCheck).forEach(word => {
        cy.get('h5').then($h5 => {
          if ($h5.text().includes(word)) {
            wordsToCheck[word] = true;
          }
        });
      });
    };

    // Function to go through 15 questions and check words
    const goThroughQuestions = () => {
      cy.wait(300)
      cy.get('#see-results').should(
        // need dummy so we pass the should either way
        (el) => {}
      ).then(
        (el) => {
          if (!el.length) {
            checkWordsInCurrentQuestion();
            cy.get('[data-cy="likert-4"]').click();
            cy.get('[data-cy="likert-button-next"]').click()
            goThroughQuestions()
          }
        }
      )
    };

    // Check words in the first 15 questions and then view the results
    goThroughQuestions();
    cy.get('[data-cy="button-see-results"]').click();

    // Click to answer more questions
    cy.get('[data-cy="start-survey-button"]').contains("more").click();

    // Answer and check words in the next 15 or N questions
    goThroughQuestions();

    // View the results and then run assertions
    cy.get('[data-cy="button-see-results"]').click().then(() => {
      // Assert that all words appeared at least once
      Object.keys(wordsToCheck).forEach(word => {
        expect(wordsToCheck[word], `Word not found: ${word}`).to.be.true;
      });
    });
  })
})
