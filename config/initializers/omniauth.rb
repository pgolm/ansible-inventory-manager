OmniAuth.config.logger = Rails.logger


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :identity, :fields => [:email]
end
