module SecureKey
  extend ActiveSupport::Concern

  module ClassMethods
    def next_secure_key
      SecureRandom.hex
    end
  end
end