module RequestSpecHelper
  include Warden::Test::Helpers

  # helper to get the JSON structure from the response body
  def json
    JSON.parse(response.body)
  end

  def sign_in_user(email: nil)
    email ||= 'test@test.com'
    user = User.find_by email: email

    sign_in user
  end

  def sign_out_user(email: nil)
    email ||= 'test@test.com'
    user = User.find_by email: email

    sign_out user
  end
end
