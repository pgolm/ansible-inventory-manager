module OmniAuthHelpers
  def set_user_session(user)
    OmniAuth.config.mock_auth[:identity] = {
      "uid" => user.id,
      "provider" => 'identity',
      "info" => {
        "email" => user.email
      }
    }
    visit "/auth/identity"
  end
end