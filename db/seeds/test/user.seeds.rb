if !User.find_by(email: 'test@test.com')
  User.create(
    name: 'test',
    email: 'test@test.com',
    password: 111111
  )
end
