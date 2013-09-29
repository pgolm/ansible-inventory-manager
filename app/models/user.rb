class User < ActiveRecord::Base
  include SecureKey

  has_many :inventories
  
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
end
