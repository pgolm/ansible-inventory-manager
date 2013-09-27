class User < ActiveRecord::Base
	def self.create_with_omniauth(auth)
	  create! do |user|
	    user.provider = auth["provider"]
	    user.uid = auth["uid"]
	    user.email = auth["info"]["email"]
	  end
	end

  def identity
    if has_identity?
      Identity.find_by(email: self.email)
    end
  end

  def has_identity?
    self.provider == 'identity'
  end

  def self.generate_api_key
    SecureRandom.hex
  end
end
