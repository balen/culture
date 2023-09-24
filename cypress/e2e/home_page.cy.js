/*
 *

https://docs.cypress.io/guides/end-to-end-testing/testing-your-app
https://github.com/testdouble/cypress-rails
https://bootrails.com/blog/rails-cypress-testing/
 */
describe('The Home Page', () => {
  it('successfully loads', () => {
    cy.visit('/') 
  })
})
