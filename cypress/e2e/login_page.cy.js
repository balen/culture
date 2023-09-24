describe('The Login Page', () => {
  it(
    'sets auth cookie when logging in via form submission',
    function () {
      const username = 'test@test.com'
      const password = '111111'

      cy.login(username, password)

      cy.getCookie('_culture_session').should('exist')
      cy.get('.navbar-text').should('contain', `${username}`)
    }
  )
})
